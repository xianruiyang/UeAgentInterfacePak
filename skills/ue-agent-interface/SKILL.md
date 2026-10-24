---
name: ue-agent-interface
description: 通过 ueagentinterfacecmd CLI、uai Python SDK 和项目生命周期入口操作 Unreal Editor；用于公开查询、HJSON 资产与场景编辑、资产预览、PIE 和真实读回。只使用公开接口与结果，不直接调用 HTTP 或处理机器身份。
---
# UE Agent Interface

通过公开 UAI 操作 UE。单次查询或命令用 `ueagentinterfacecmd`；需要连续处理结果、workspace 或会话 handle 时用 Python SDK。
实际状态以公开调用结果为准；本 skill 不复制完整命令手册或领域 schema。

## 必要边界

- 使用公开 CLI、`uai` SDK 或项目正式 runner，不直接 HTTP、不恢复旧 `uai_core`，不在 Python 复制 UE/HJSON 业务。
- 只消费公开 Result 和 handle；不读取 SDK 私有成员、隐藏 `.uai`、raw wire、机器身份或认证凭据。
- 默认复用并保持用户 Editor；UAI 插件开发不使用 Live Coding，不以强杀替代正常退出。
- 写入、删除、保存、关闭和外部影响以当前用户授权为准，skill 不创建授权。

## 先选择工作路径

| 当前目标 | 操作路径 |
| --- | --- |
| 查询命令、候选或资产状态；执行单次命令 | [CLI](references/cli.md)：内联参数，直接读取公开结果 |
| 新建资产目标 | [新增内容](references/hjson-workspace.md#新增内容)：按领域创建合同选择初始化文档或 factory，创建后导出 workspace |
| 编辑已有目标的图、属性、曲线等内容 | [HJSON workspace](references/hjson-workspace.md)：查所需候选，直接编辑，再导入 |
| 资产预览调试：观察材质、动画、Niagara 等资产自身效果 | [资产预览](references/asset-preview.md)：编辑 workspace 根下的 `preview/`，执行原生动作或截图 |
| 场景制作：摆放内容并完成目标画面 | [场景制作](references/scene-creation.md)：在 Editor 中完成布局、材质、照明、曝光、后处理和视角 |
| 运行时 PIE 调试：验证输入、交互及游戏运行逻辑 | [PIE 流程](references/pie.md)：输入、等待、截图；必要时才操作属性 |

这里的“资产预览”也包括用户所称的“资产 PIE”，实际使用各资产编辑器的原生预览，不启动关卡 PIE。
按目标选择路径；资产自身效果优先用资产预览，场景效果用 Editor 视口，依赖游戏运行的行为才用运行时 PIE。
这些路径不是每次任务都要执行的固定阶段。

## 公共做法

1. 明确目标和所需变化。已有有效状态与接口信息直接复用，只补影响当前动作的未知。
2. 不知道命令时用公开 `command_search`，只对选中的命令取得 `command_usage`。
   已知命令和参数直接执行；usage 是 SDK 示例。参数名或嵌套形状不明确时用 CLI 的 `describe` 按需读取，领域语义再查所属合同。
3. 普通 HJSON 增删改使用文件搜索和补丁工具，编辑后 `open_workspace(...).import_changes()`；
   不为少量字段或分片编写解析重写脚本。大量重复生成或计算变换才按需用脚本。
   空集合或新增记录的形状不明时，按 workspace 的 `examples/index.hjson` 定位当前生成的只读示例。
4. 已确定的操作按依赖连续执行并逐项检查结果；已有 SDK 会话中可直接查询，不机械切换入口。
   成功结果只输出下一判断需要的字段；需要留证的完整公开结果存任务文件。
5. 复用入口已经完成的编译、保存和独立读回，不机械追加验证；运行与视觉目标用对应真实证据。

参数或调用方式错误按公开诊断纠正，不直接判为插件故障。写入超时、崩溃或返回与实际状态冲突时，
先保留证据并核对受影响状态，不盲目重放；已确认公共能力缺陷交所属 owner 处理。

## 需要时补读

| 当前需要 | 参考 |
| --- | --- |
| CLI 连接、安装与卸载、命令发现和参数 | [CLI](references/cli.md) |
| 连续 SDK 操作、文件产物、非 PIE 长任务、项目机器收据 | [SDK 与 runner](references/sdk-and-runners.md) |
| 启动、关闭或恢复 Editor | [Editor 生命周期](references/editor-lifecycle.md) |
| 判断已有结果是否足够、选择补充证据或 UE 知识来源 | [验证与知识](references/verification-and-knowledge.md) |

只读当前动作所需的参考，复用预安装环境。启动、安全关闭等生命周期继续使用项目正式 runner；
领域字段从当前生成签名和正式合同定位，不从其他资产类推。

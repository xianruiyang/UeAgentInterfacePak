# UeAgentInterfacePak

`UeAgentInterfacePak` 是 `UeAgentInterface` 插件和配套 Codex skills 的分发包。它用于把 Unreal Editor 自动化插件、AI 侧 skill 文档和 skill 内部 CLI 工具放在同一个包仓库里，方便在新 UE 项目或新 Codex 环境中恢复同一套工作流。

本包包含三类内容：


| 路径                   | 用途                                                                                                        | 是否需要用户安装 |
| ---------------------- | ----------------------------------------------------------------------------------------------------------- | ---------------- |
| `UeAgentInterface/`    | Unreal Editor 插件 submodule。安装到 UE 项目的`Plugins/UeAgentInterface` 后，在编辑器内提供本地自动化服务。 | 需要             |
| `skills/`              | Codex skill 包。主要使用`ue-agent-interface`，并附带 `ue-engine-knowledge`、`leveldesign`。                 | 需要             |
| `UeAgentInterfaceCMD/` | CLI 源码和构建产物仓库，主要用于开发和打包 skill 内部工具。                                                 | 不需要单独安装   |

`UeAgentInterfaceCMD` 只作为 skill 内工具的开发仓库保留。普通使用时不要把它作为独立组件安装；`ue-agent-interface` skill 会使用自身 `tools/uai-cli.exe` 中的工具。

## 适用版本

- 当前包按 `GptProjectTest` 的实际环境整理，目标 Unreal Engine 版本为 `5.6`。
- 当前插件版本为 `UeAgentInterface.uplugin` 中的 `VersionName: 0.1`。
- 当前插件是 Editor 插件，目标平台为 `Win64`。
- 插件依赖 UE 内置或项目可启用插件：`EnhancedInput`、`Niagara`、`ModelingToolsEditorMode`、`MeshModelingToolset`、`IKRig`。
- 当前代码仍标记为 Beta，建议优先在项目副本或版本控制可回退的工程里使用。

## 获取包内容

克隆或复制本包后，先确认 submodule 已拉取：

```powershell
git submodule update --init --recursive
```

如果只需要插件，也可以直接使用公开插件仓库：

```powershell
git clone https://github.com/xianruiyang/UeAgentInterface.git .\Plugins\UeAgentInterface
```

如果使用整个包仓库，后续安装时从 `UeAgentInterfacePak/UeAgentInterface` 复制或引用插件目录即可。

## 插件安装

1. 在目标 UE 项目根目录创建 `Plugins` 目录。
2. 将本包中的 `UeAgentInterface/` 放到目标项目的 `Plugins/UeAgentInterface/`。
3. 如果项目是 C++ 项目，重新生成工程文件并编译 Editor target。
4. 打开 `.uproject`，确认插件启用。可以在 `.uproject` 的 `Plugins` 数组中加入：

```json
{
  "Name": "UeAgentInterface",
  "Enabled": true,
  "SupportedTargetPlatforms": [
    "Win64"
  ]
}
```

也可以在 Unreal Editor 的 Plugins 窗口里搜索并启用 `UeAgentInterface`。启用后如 UE 要求重启编辑器，按提示重启。

## Skill 安装

将本包 `skills/` 下需要的 skill 复制到 Codex 的 skills 目录：

```powershell
$SkillRoot = "$env:USERPROFILE\.codex\skills"
New-Item -ItemType Directory -Force -Path $SkillRoot | Out-Null
Copy-Item -Recurse -Force .\skills\ue-agent-interface "$SkillRoot\ue-agent-interface"
Copy-Item -Recurse -Force .\skills\ue-engine-knowledge "$SkillRoot\ue-engine-knowledge"
Copy-Item -Recurse -Force .\skills\leveldesign "$SkillRoot\leveldesign"
```

安装后重启 Codex 会话或重新加载 skills。常用方式：

- 使用 `$ue-agent-interface` 执行 UE 编辑器自动化、JSON/folder 结构化资产编辑、截图、smoke 验证等。
- 使用 `$ue-engine-knowledge` 查询 UE 领域知识和官方文档优先的实现建议。
- 使用 `$leveldesign` 处理白盒关卡设计和关卡结构审查。

如果本机已经有同名 skill，复制前先备份旧目录，避免覆盖本地未提交的修改。

要注意，codex安装skill后，要开启新对话才能使用。首次使用时最好显式引用所需的skill，以防模型没有自动加载。

## 插件开启方法

安装并启用插件后，在 Unreal Editor 中打开目标项目，然后从菜单启动服务：

`Window` -> `UeAgentInterface` -> `Start UeAgentInterface Server`

<img src="docs/images/ue-agent-interface-menu.png" alt="UE 菜单中的 UeAgentInterface 服务入口" width="720">

同一菜单还提供：

- `Stop UeAgentInterface Server`：停止编辑器内服务。
- `Copy Connection Info`：复制当前连接信息，便于 CLI 或 skill 检查连接。

启动后可以用 skill 内工具做连接检查：

```powershell
.\skills\ue-agent-interface\tools\uai-cli.exe doctor --json-output
```

实际自动化工作应通过 `ue-agent-interface` skill 调用 `uai-cli.exe`，不要直接调用 HTTP 接口。

## 推荐工作流

1. 先启动 UE 项目，并通过菜单开启 `UeAgentInterface Server`。
2. 在 Codex 中使用 `$ue-agent-interface` skill。
3. 创建或修改资产时优先走 JSON 或 folder 结构化 JSON 工作流。
4. 应用后检查命令返回中的错误、warning、Niagara Stack issue、compile log 和 dirty resource。
5. 需要窗口验证时，默认最小化或不抢焦点启动 UE，避免影响当前桌面操作。

## 目录说明

```text
UeAgentInterfacePak/
  README.md
  docs/images/
    ue-agent-interface-menu.png
  skills/
    ue-agent-interface/
    ue-engine-knowledge/
    leveldesign/
  UeAgentInterface/
  UeAgentInterfaceCMD/
```

## 开发说明

- `UeAgentInterface/` 和 `UeAgentInterfaceCMD/` 是 Git submodule，更新它们时应先在各自仓库提交，再回到本包仓库更新 gitlink。
- `skills/` 是本包直接分发的 skill 内容，更新后需要同步到真实 Codex skills 目录再验证。
- `UeAgentInterfaceCMD/` 面向 skill 内部工具开发和 `uai-cli.exe` 打包，不作为最终用户安装步骤。
- 初步代码由 GPT 辅助编写，后续维护应以真实编译、自动化测试、UE 内验证和文档同步为准。

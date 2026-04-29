# Control Rig 与动画 IK Authoring 速查

## 适用场景

制作或修复以下内容时读取本文件：

- Control Rig 求解图、层级、变量、Control、Shape Library。
- 足底贴地、手部贴合、武器约束、程序化姿态修正。
- AnimBlueprint 中的 Control Rig 节点接入。
- 依赖 Trace、碰撞、动画曲线权重、楼梯/斜坡适配的运行时 IK。

## 资产职责

- `Control Rig`：保存层级、变量、Control、RigVM 求解图和预览配置。它只定义如何从输入姿态、变量和世界查询求解输出姿态。
- `AnimBlueprint`：负责把 Control Rig 节点插入动画流程，决定是否执行、输入/输出 Pose 是否同步、Alpha/LOD/曲线权重如何驱动。
- `AnimSequence`：可通过 float curve 驱动 IK 权重、脚锁定、步态阶段或手部贴合阶段。曲线要按帧回读最大值、key 数和时间位置。
- `Level / StaticMesh / Component Collision`：决定角色胶囊、Trace、Sweep、Overlap 实际命中的对象。胶囊通行语义和 IK Trace 语义可以不同，但必须是有意设计。
- `Control Rig Shape Library`：只保存编辑器控制形状 mesh/material/name。它不参与 RigVM 求解，也不会改变运行时逻辑。

## 推荐流程

1. 先创建或复制最小资产，不直接手写完整 `.uasset` 行为。
2. `control_rig_export_folder` 导出真实结构。
3. 基于导出 JSON 修改 `variables/variables.json`、`hierarchy/*.json`、`shape_libraries/references.json`、`graphs/graphs.json`。
4. 如果要替换整个求解图，在 `graphs/graphs.json` 使用 `replace_nodes=true`，并只保留目标图需要的 node/link/pin default。局部追加时保持 `replace_nodes=false`。
5. `control_rig_validate_folder` 做只读校验，确认 `json_issue_count=0`。
6. `control_rig_apply_folder` 回写并编译，检查 `valid`、`error_count`、`warning_count`、`compile_report.error_count`、`readback`。
7. 重新 export 或用 `control_rig_get_compile_log / control_rig_runtime_probe` 读回验证。
8. 如果要接入动画蓝图，另外走 `anim_blueprint_export_folder / anim_blueprint_apply_folder / anim_blueprint_compile`。
9. 如果要驱动 IK 权重，另外走 `anim_sequence_set_curve` 或 `curve_apply_json`，再用 `anim_sequence_get_info(include_curve_keys=true)` 或对应 curve export 回读。

## RigVM Graph 规则

- 不凭记忆写 unit、pin 名和默认值。先 export，再看 `validation/rigvm_unit_registry.json` 和导出的 pin 路径。
- 不使用 UI 标记为 `OutDated` 的 unit。发现旧节点时优先替换成当前 UE 版本的 registry 中可用 unit。
- Graph apply 后必须编译。HTTP 成功只代表命令执行完，不代表 Control Rig 有效。
- 只修改逻辑所需字段。导出的只读或缓存字段，例如 transform cache、运行时 pin 临时值、readonly/raw profile，不要复制回写。
- pin default 写入失败、unit 不存在、link 连接失败、变量默认值导入失败，都必须当成硬问题处理，不用截图覆盖判断。

## AnimBlueprint 接入规则

- Control Rig 节点是否生效，首先看 AnimBlueprint 中的节点配置，不只看 Control Rig 资产是否编译成功。
- 需要读回并验证：
  - `Node.ControlRigClass`
  - `Node.DefaultControlRigClass`
  - `Node.bExecute`
  - `Node.InputSettings.bUpdatePose`
  - `Node.OutputSettings.bUpdatePose`
  - `Node.Alpha / Node.AlphaInputType / Node.AlphaCurveName / Node.LODThreshold`
- 修改后必须 `anim_blueprint_compile`，再 export 或 inspect 节点确认写入没有被 UE 规范化或回退。
- 如果 Control Rig 独立 probe 有效果，但角色运行时无效果，优先排查 AnimBlueprint 节点没有接入、没有执行、Pose 没同步、Alpha 为 0、LOD 屏蔽或曲线权重为 0。

## Trace 与碰撞规则

- 先确认使用的 RigVM Trace unit 的空间语义。UE 5.6 的 Control Rig `SphereTraceByObjectTypes` 常见输入/输出是 Rig/Global 语义，内部再查询 UE world，不应额外做一次错误的世界变换。
- Trace 起点和终点必须能解释成明确方向。足底贴地通常是脚当前世界/全局位置上方到下方，而不是固定原点或错误局部空间。
- 用于地面的 Trace 不要默认走 `Visibility` 并命中角色自身。常用做法是 object types 限定到 `WorldStatic`；若支持移动平台，再定义明确的地面 object/channel。
- no-hit 必须有显式分支：保持动画姿态、降低 IK alpha，或使用上一帧平滑目标。不能让 no-hit 的默认零向量继续参与求解。
- 命中点、命中法线、是否命中、Trace 起终点应能通过调试 control、变量采样、probe 或日志读到。
- 角色胶囊通行与足部 Trace 可使用不同碰撞：胶囊可走简化 ramp，足部可命中视觉台阶或脚底辅助面。但如果两套语义混在一起，容易出现角色移动顺滑而脚贴地抖动，或 Trace 命中辅助面导致胶囊被卡。

## 足底/手部 IK 设计规则

- 运行时 IK 不应完全替代动画。它应该在动画已经接近正确的基础上做修正。
- 移动中不要强行满权重锁脚。用动画曲线或速度/步态阶段降低摆动脚权重，只在支撑期提高权重。
- 足部贴地通常保留动画的水平位置，只用 Trace 结果修正高度和必要旋转。把预测落点完整 X/Y/Z 直接喂给脚目标，容易造成脚在地面上横向拖拽。
- 楼梯和斜坡需要平滑目标、限制最大修正量、限制 pelvis/root 下压/抬升速度，并让脚锁定曲线有过渡段。
- 手部/武器 IK 同理：保留动画主形体，只用目标约束修正末端，不要让 IK 把全身姿态拉坏。
- PBIK/FBIK/TwoBoneIK 参数要用读回和 A/B 验证调。root behavior、pelvis stiffness、chain pull、rotation pin、position alpha 过强都会造成悬空、内八、膝盖异常或移动卡顿。

## 动画曲线规则

- IK 曲线应表达语义，例如 `FootIK_Left`、`FootIK_Right`、`FootLock_Left`、`FootLock_Right`、`HandIK_Weapon`。
- 曲线 key 不要只看是否存在，要读回 key 数、时间、最大值、插值和压缩后结果。
- 对移动动画，脚 IK 曲线通常有支撑期峰值和摆动期低值。全程 1.0 容易脚锁死；全程 0.0 则看起来 Control Rig 没生效。
- 写曲线优先用 `ue_agent_interface.curve.v1` 的 `curve_json`，失败时检查 `json_issues[]`。

## Shape Library 规则

- Shape Library 用来让控制点在编辑器里更容易识别，例如脚目标用脚印形状、手目标用手柄形状、Trace 调试点用小球或十字。
- Shape Library 可以跨相同或相似控制命名的人形 Control Rig 复用，但只复用显示形状，不复用求解图、变量或骨骼映射。
- 换 Shape Library 不会修复 IK 无效、Trace 错误、Alpha 为 0、AnimBlueprint 未接入等逻辑问题。

## 验证清单

- `control_rig_validate_folder`：`valid=true`、无 error。
- `control_rig_apply_folder`：检查 `issues[]`、`compile_report`、`readback`。
- `control_rig_get_compile_log`：确认无编译错误。
- `control_rig_runtime_probe`：确认事件被执行，变量/骨骼/control 读回符合预期；如果返回 `execution_skipped=true`，不能当作已执行。
- `anim_blueprint_apply_folder / anim_blueprint_compile`：确认 Control Rig 节点类、执行开关、Pose 同步和 Alpha/Curve 写入。
- `anim_sequence_get_info(include_curve_keys=true)`：确认 IK 曲线实际存在且数值合理。
- `level_trace_world_ray / level_sweep_capsule_path / level_check_overlaps`：确认碰撞语义与运行时需求一致。
- `editor_list_dirty_resources`：结束前明确保存或丢弃脏资源，不留下悬而未决的 editor 状态。

## 常见误判

- 只看 Control Rig 编辑器内图，不看 AnimBlueprint 节点，导致“Rig 有效果但运行时没效果”。
- 只截第 0 帧或单帧截图，就判断运行时事件、曲线或步态无效。
- Trace 命中角色自身或辅助面，却误以为命中了地面。
- 把 Rig/Global、Local、World 空间混用，导致起点终点看似有值但方向不对。
- no-hit 时把默认零向量参与求解，脚或手被拉到异常位置。
- 把 Shape Library 当成逻辑资产，以为换形状能改变求解。
- 用可视截图替代 `compile_report`、`readback`、`runtime_probe`、曲线回读和碰撞查询。

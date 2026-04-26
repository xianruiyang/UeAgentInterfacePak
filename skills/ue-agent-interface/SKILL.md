---
name: ue-agent-interface
description: 使用 uai-cli.exe 驱动当前项目内的 UeAgentInterface Unreal Editor 服务。适用于 UE 编辑器自动化、资产制作、JSON/文件夹式结构化工作流、Blueprint/UMG/Material/Sequence/Niagara/Animation/IK/Modeling 指令、smoke 验证和安全的编辑器生命周期操作。不要直接调用 HTTP。
---

# UeAgentInterface Skill

## 适用范围

当需要通过项目内 `UeAgentInterface` 插件控制 Unreal Editor 时使用本 skill。

本 skill 是工作流指南，不是完整参数手册。命令参数、覆盖范围、示例和最新边界以项目内插件文档为准。

## 硬性规则

1. 必须使用 `uai-cli.exe`，不要直接调用 HTTP。
2. 可复用任务优先用 `run`，一次性批处理优先用 `batch`。
3. `plan / vars / batch / params` 使用 JSON 文件，不要在命令行里内联长 JSON。
4. 多步骤任务必须 fail fast：`stop_on_error=true`。
5. 每次写操作后都要读取生成的 report JSON。
6. 资产写入后必须按资产类型做编译、读回、smoke、截图、runtime probe 或 `coverage_report.json` 验证。
7. 已支持 JSON / 文件夹式结构化 JSON 的资产 authoring，优先走导出、修改、回写流程，不要用长串原子命令手搓。
8. 原子写入命令只用于 bootstrap、探针、迁移、schema 边界、局部修补和故障恢复；文档中标为 `Deprecated for authoring` 的命令不得作为完整制作主流程。
9. 尽量复用已经打开的 UE Editor 会话；除非必要，不启动第二个编辑器实例。
10. 不运行全屏 game 测试。默认使用最小化、不抢焦点、headless 或 `UnrealEditor-Cmd.exe -NullRHI -unattended` 验证。

## 二进制选择顺序

1. `<ProjectRoot>/UeAgentInterfaceCMD/dist/uai-cli.exe`
2. `C:/Users/gzxt/.codex/skills/ue-agent-interface/tools/uai-cli.exe`

## 阅读顺序

1. `<ProjectRoot>/readme.md`
2. `<ProjectRoot>/Plugins/UeAgentInterface/docs/UeAgentInterface_Status.md`
3. `<ProjectRoot>/Plugins/UeAgentInterface/docs/UeAgentInterface_Usage.md`
4. 只打开当前任务需要的分册：`<ProjectRoot>/Plugins/UeAgentInterface/docs/commands/`
5. CLI 细节按需读取：
   - `<ProjectRoot>/Plugins/UeAgentInterface/docs/Workflow_ExecBatch_Practice.md`
   - `<ProjectRoot>/UeAgentInterfaceCMD/docs/USAGE.md`
6. 本 skill 内置的速查：
   - `references/command-map.md`
   - `references/batch-execution-playbook.md`

## 命令文档路由

- Core / Level / Viewport / Assets / Landscape：`01_Core_Level_Assets_Landscape.md`
- Blueprint：`02_Blueprint.md`
- UMG / WidgetBlueprint：`03_UMG.md`
- StaticMesh / EnhancedInput：`04_StaticMesh_EnhancedInput.md`
- Material / Material Instance / Material Function：`05_Material.md`
- Level Sequence / UMG Animation / Sequencer：`06_Sequence.md`
- Niagara System：`07_Niagara_System.md`
- Niagara Emitter / Renderer / Event / Parameter：`08_Niagara_Emitter.md`
- Niagara Stage Graph / Module Input：`09_Niagara_StageGraph.md`
- Modeling Mode：`10_Modeling.md`
- AnimBlueprint：`11_AnimBlueprint.md`
- Montage：`12_Montage.md`
- Animation Assets / Skeleton：`13_AnimationAssets_Skeleton.md`
- IK Rig / IK Retargeter：`14_IKRig_IKRetargeter.md`
- Niagara System / Emitter / Script 文件夹式 JSON：`15_Niagara_FolderFormat.md`
- 废弃写入命令归档：`deprecatedCommand/README.md`

## 标准工作流

1. 确认 UE Editor 已运行。
2. 确认插件服务已启动：`Window -> UeAgentInterface -> Start UeAgentInterface Server`。
3. 先运行 `uai-cli.exe doctor --json-output`。
4. 可复用/参数化任务使用 `uai-cli.exe run --plan <plan.json> --vars <vars.json> --json-output`。
5. 临时批处理任务使用 `uai-cli.exe batch --file <batch.json> --json-output`。
6. 读取 report JSON；如果失败，先根据 `failed_index / failed_command / failed_error` 定位根因，再继续。

## 资产编辑优先级

优先级从高到低：

1. 单文件 JSON：
   - `asset_export_property_json / asset_apply_property_json`
   - `enhanced_input_export_action_json / enhanced_input_apply_action_json`
   - `enhanced_input_export_mapping_context_json / enhanced_input_apply_mapping_context_json`
   - `montage_export_json / montage_apply_json`
2. 文件夹式结构化 JSON：
   - `blueprint_export_folder / blueprint_apply_folder`
   - `umg_export_folder / umg_apply_folder`
   - `anim_blueprint_export_folder / anim_blueprint_apply_folder`
   - `material_export_folder / material_apply_folder`
   - `material_instance_export_folder / material_instance_apply_folder`
   - `material_function_export_folder / material_function_apply_folder`
   - `sequence_export_folder / sequence_apply_folder`
   - `niagara_export_folder / niagara_apply_folder`
   - `niagara_emitter_export_folder / niagara_emitter_apply_folder`
   - `niagara_script_export_folder / niagara_script_apply_folder`
3. 原子命令：
   - 只用于创建最小骨架、读取 live 信息、探针验证、迁移脚本、schema 边界字段和回写失败后的定点补修。

对属性面很大的资产使用固定节奏：

`bootstrap -> export -> refine -> apply -> export -> refine -> apply -> verify`

不要靠记忆猜 `property_name` 和 `value_text`。先让 UE 生成真实对象，再以导出的 JSON 为模板修改。

## JSON 与属性写入诊断

任何 `value_text`、单文件 JSON 或文件夹式 JSON 写入后，都要检查命令返回中存在的诊断字段：

- `requested_value_text`
- `applied_value_text`
- `property_value_read_back`
- `property_import_status`
- `property_import_verified`
- `property_import_error`
- `value_text_exact_match`
- `value_text_changed_after_import`
- `cpp_type`

把 `property_import_status=property_not_found` 或 `property_import_status=import_failed` 当成硬失败处理。`value_text_changed_after_import=true` 需要人工复核；它可能只是 UE 规范化文本，也可能说明向量、颜色、枚举或对象引用实际回退。

JSON / 文件夹式 JSON 的解析失败必须在 report 中可见：

- 单文件 `json_file` 读取或解析失败返回 `json_file_not_found`、`load_json_file_failed` 或 `json_parse_failed`。
- 文件夹式 workflow 的可选 JSON 文件只有“不存在”时可跳过；只要存在但读取或解析失败，apply 必须失败并带文件路径。
- 可恢复的坏数组项进入 `warnings[] / warning_count` 或 `property_results[]`，不得静默忽略。

## 当前能力地图

- Level / Actor / Component / Viewport：Actor 放置、transform、选择、Outliner folder/tag、截图、screen trace、NavMesh、collision sweep、bounds/vertex/face 对齐。
- Asset / Editor lifecycle：打开/保存资产、复制/导入部分资产、属性 JSON、dirty resource 列表/处理、安全关闭。
- Blueprint：folder workflow、变量、组件、事件/自定义事件、函数调用节点、通用类节点、变量节点、连线/断线、视图/截图辅助。
- UMG：WidgetBlueprint folder workflow、WidgetTree、常用 widget/slot 属性、变量/函数绑定、常见动画轨道、Blueprint 图复用。
- StaticMesh：bounds/corners、材质、collision primitive、socket、preview/property 辅助。
- EnhancedInput：InputAction 与 InputMappingContext 创建/编辑，以及单文件 JSON round-trip。
- Material：Material / Material Instance / Material Function folder workflow、表达式图、统一参数设置。
- Sequence：Level Sequence folder workflow、actor/component/spawnable binding 恢复、property/spawn track、outliner folder、camera cut、subsequence、cinematic shot、UMG animation helper。
- Niagara：`NiagaraSystem / NiagaraEmitter / NiagaraScript` 完整 folder profile；Stack issue 读取、Quick Fix、System refresh、runtime probe、screenshot、compile log、apply 后直接返回红黄感叹号信息。
- AnimBlueprint：folder workflow、Layer Interface、Anim Layer、State Machine、Transition、图节点、预览 mesh/camera、CDO 属性写入。
- Montage：单文件 JSON workflow、slot track、segment、section、next-section、notify track/notify/notify state、Skeleton slot/group 辅助。
- Animation Assets / Skeleton：AnimSequence 信息/截图/settings/curve/bone/metadata/notify/sync marker，Skeleton bone/compatible skeleton/preview mesh/socket/virtual bone。
- IK Rig / IK Retargeter：资产创建、preview mesh、goal、retarget root/chain、solver、auto retarget definition、retargeter rig/settings/pose/auto map/duplicate-and-retarget。
- Modeling：模式激活、选择、active tool property/action、accept/cancel、primitive wrapper、mesh edit wrapper、collision/UV/material helper。

## Niagara 专项规则

- 完整 Niagara 效果制作必须走文件夹式结构化 JSON，不用零散原子命令手搓完整 System。
- `validation/coverage_report.json` 是覆盖状态源真相；完整 profile 应为 `implementation_status=complete_folder_profile`、`is_complete_target_schema=true`、空 `pending_profiles`、空 `blocking_gaps`。
- `niagara_apply_folder` 与 `niagara_emitter_apply_folder` 默认在 apply 后编译并打开/复用 Niagara editor ViewModel 读取 Stack issue。直接检查 `stack_issue_report`、`stack_issues`、`stack_scopes`、`stack_error_count`、`stack_warning_count`、`stack_issue_view_model_source`。
- UI 红色感叹号与 compile log 不一定一致；读取 UI 同源内容时使用 `niagara_get_stack_issues(prefer_existing_view_model=true, open_editor_if_needed=true)`。
- 写入后 System 没粒子、必须手动加/删 emitter 才恢复时，先执行 `niagara_refresh_system`，再读 compile log、Stack issue 和 runtime probe。
- Vector / Position / LinearColor 等 module input 必须使用 UE 结构化文本，例如 `(X=...,Y=...,Z=...)`、`(R=...,G=...,B=...,A=...)`，并检查写后 readback。
- Collision 相关效果优先使用默认 Ray Trace collision；碰撞后生成粒子应通过 Event Handler 接收碰撞事件，在事件 payload 位置生成，不要用静态位置假冒。
- Event Handler 中不要无意义重复 `Initialize Particle` 覆盖事件 payload。`Kill Particles` 不应清理承载给后续事件的变量。
- UE 崩溃后第一优先级是找根因并修复指令/数据路径，不继续堆绕路操作。

## 编辑器会话与关闭卫生

- 优先连接当前 editor；如果已有 editor，先 `doctor`。
- 通过项目 task 或 `scripts/ue/RunEditor.ps1` 拉起 GUI editor 时默认最小化且不抢焦点。
- 如果 C++ / 插件改动需要构建，而 UE 占用 DLL，只有在 dirty resource 已处理后才走安全关闭。
- 安全关闭流程：
  1. `editor_list_dirty_resources`
  2. `editor_resolve_dirty_resources`
  3. `editor_close`
- 不要把配置文件已改当成当前 editor 会话已加载；必须用 live editor 状态验证。
- smoke 后确认没有残留 `UnrealEditor` 或 `UnrealEditor-Cmd` 进程。

## 服务不可用处理

如果 `doctor` 失败：

1. 停止写操作。
2. 如果没有 editor，使用项目 task 或 `scripts/ue/RunEditor.ps1` 的最小化/no-activate 默认路径启动。
3. 如果 editor 已运行，请用户从 `Window -> UeAgentInterface -> Start UeAgentInterface Server` 启动服务。
4. 重新运行 `doctor`，成功后再写入。

## 清理策略

触发条件：

- `tmp/*.json` 超过 120 个
- `dist/reports/*.json` 超过 200 个

保留策略：

- `tmp` 保留最新 40 个
- `dist/reports` 保留最新 120 个

使用：

`scripts/cleanup_uai_json.ps1 -ProjectRoot <ProjectRoot>`

## 输出要求

每次使用本 skill 完成 UAI 操作后必须说明：

1. 使用模式：`run` 或 `batch`
2. 输入 JSON 路径
3. report JSON 路径
4. 成功/失败和失败索引
5. 已执行的验证
6. 剩余 warning、dirty resource 或 editor/process 清理状态

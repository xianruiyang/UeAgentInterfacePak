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
5. 使用任何 UAI 指令前，必须先查清该指令每个参数的意义、默认值、副作用、返回字段和验证方式；不确定时先读对应命令文档或用只读/导出指令获取真实结构。
6. 每次写操作后都要读取生成的 report JSON。
7. 资产写入后必须按资产类型做编译、读回、smoke、截图、runtime probe 或 `coverage_report.json` 验证。
8. 已支持 JSON / 文件夹式结构化 JSON 的资产 authoring，优先走导出、修改、回写流程，不要用长串原子命令手搓。
9. 原子写入命令只用于 bootstrap、探针、迁移、schema 边界、局部修补和故障恢复；文档中标为 `Deprecated for authoring` 的命令不得作为完整制作主流程。
10. 尽量复用已经打开的 UE Editor 会话；除非必要，不启动第二个编辑器实例。
11. 不运行全屏 game 测试。默认使用最小化、不抢焦点、headless 或 `UnrealEditor-Cmd.exe -NullRHI -unattended` 验证。

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
   - `references/cli-diagnostics-release.md`：排查 CLI 失败、黑图、crash capture、命令覆盖矩阵或 Pak 发布验证时读取。
   - `references/niagara-vfx-authoring.md`：制作或修复 Niagara 视觉效果、主形体、分层、材质、锚点、事件链或美术质量问题时读取。
   - `references/control-rig-animation-authoring.md`：制作或修复 Control Rig、足底/手部 IK、运行时 Trace、AnimBlueprint Control Rig 接入、Shape Library、动画曲线 IK 权重、楼梯/斜坡贴合或 IK 调试时读取。

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
- Skeletal Mesh 文件夹式 JSON：`16_SkeletalMesh_FolderFormat.md`
- Control Rig / Shape Library 文件夹式 JSON：`17_ControlRig_FolderFormat.md`
- Deformer / ML Deformer / Geometry Cache：`18_Deformer_MLDeformer_GeometryCache.md`
- AI Behavior / Blackboard / StateTree / EQS / Navigation / SmartObject：`19_AI_Behavior_Blackboard_StateTree_EQS_Navigation_SmartObject.md`
- Audio：`20_Audio.md`
- Texture / RenderTarget / Media：`21_Texture_RenderTarget_Media.md`
- Project Settings / Config：`22_ProjectSettings_Config.md`
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
   - `curve_export_json / curve_apply_json`
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
   - `skeleton_export_folder / skeleton_apply_folder`
   - `static_mesh_export_folder / static_mesh_apply_folder`
   - `skeletal_mesh_export_folder / skeletal_mesh_apply_folder`
   - `ik_rig_export_folder / ik_rig_apply_folder`
   - `ik_retargeter_export_folder / ik_retargeter_apply_folder`
   - `control_rig_export_folder / control_rig_apply_folder`
   - `deformer_graph_export_folder / deformer_graph_apply_folder`
   - `sound_cue_export_folder / sound_cue_apply_folder`
   - `metasound_export_folder / metasound_apply_folder`
   - `sound_attenuation_export_json / sound_attenuation_apply_json`
   - `sound_concurrency_export_json / sound_concurrency_apply_json`
   - `sound_class_export_json / sound_class_apply_json`
   - `sound_mix_export_json / sound_mix_apply_json`
   - `sound_submix_export_folder / sound_submix_apply_folder`
   - `audio_effect_preset_export_json / audio_effect_preset_apply_json`
   - `runtime_virtual_texture_export_json / runtime_virtual_texture_apply_json`
   - `texture_array_export_folder / texture_array_apply_folder`
   - `texture_cube_export_folder / texture_cube_apply_folder`
   - `texture_cube_array_export_folder / texture_cube_array_apply_folder`
   - `volume_texture_export_folder / volume_texture_apply_folder`
   - `render_target_export_json / render_target_apply_json`
   - `media_source_export_json / media_source_apply_json`
   - `media_player_export_json / media_player_apply_json`
   - `media_texture_export_json / media_texture_apply_json`
   - `texture_graph_export_folder / texture_graph_apply_folder`
   - `subuv_animation_export_json / subuv_animation_apply_json`
   - `paper_sprite_export_json / paper_sprite_apply_json`
   - `paper_flipbook_export_json / paper_flipbook_apply_json`
   - `paper_tileset_export_folder / paper_tileset_apply_folder`
   - `paper_tilemap_export_folder / paper_tilemap_apply_folder`
   - `texture_collection_export_json / texture_collection_apply_json`
   - `project_settings_export_index / project_settings_export_page / project_settings_validate_page / project_settings_diff_page / project_settings_apply_page`
   - `control_rig_shape_library_export_json / control_rig_shape_library_apply_json`
3. 原子命令：
   - 只用于创建最小骨架、读取 live 信息、探针验证、迁移脚本、schema 边界字段和回写失败后的定点补修。

对属性面很大的资产使用固定节奏：

`bootstrap -> export -> refine -> apply -> export -> refine -> apply -> verify`

不要靠记忆猜 `property_name` 和 `value_text`。先让 UE 生成真实对象，再以导出的 JSON 为模板修改。
曲线类资产或曲线属性不要猜 `value_text`；优先使用 `ue_agent_interface.curve.v1`。资产级走 `curve_export_json / curve_apply_json`，属性级走 `asset_export_property_json / asset_apply_property_json` 返回的 `curve_json`；`value_json` 只是兼容别名。导出中两者同时存在时编辑 `curve_json`，apply 失败必须检查 `json_issues[]`，并确认失败没有把资产标脏或产生部分 channel 写入。

Blueprint / UMG / AnimBlueprint 变量统一使用 `pin_category/pin_subcategory/pin_subcategory_object/container_type/value_type`。常用结构体、枚举、对象/类别名已集中在插件 `docs/commands/02_Blueprint.md`；使用前先查清参数含义和目标类型，不要凭印象写字段。

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
- 曲线 JSON 写入必须检查 `json_issues[]`；未知字段、拼写相近字段、缺 key 值、重复时间、非法插值/切线/外推模式都应视为有效诊断信号。

## 当前能力地图

- Level / Actor / Component / Viewport：Actor 放置、transform、选择、Outliner folder/tag、截图、screen trace、NavMesh、collision sweep、bounds/vertex/face 对齐。
- Asset / Editor lifecycle：打开/保存资产、复制资产、贴图/FBX 导入、属性 JSON、曲线 JSON、dirty resource 列表/处理、安全关闭。
- Blueprint：folder workflow、变量、组件、事件/自定义事件、函数调用节点、通用类节点、变量节点、连线/断线、视图/截图辅助。
- UMG：WidgetBlueprint folder workflow、WidgetTree、常用 widget/slot 属性、变量/函数绑定、常见动画轨道、Blueprint 图复用。
- StaticMesh：folder workflow 覆盖材质、socket、simple collision、lightmap、Nanite 安全字段；reimport 和 collision preview 有显式命令；raw geometry / UV / Nanite 内部数据只读摘要或走导入/建模命令。
- EnhancedInput：InputAction 与 InputMappingContext 创建/编辑，以及单文件 JSON round-trip。
- Material：Material / Material Instance / Material Function folder workflow、表达式图、统一参数设置。
- Sequence：Level Sequence folder workflow、actor/component/spawnable binding 恢复、property/spawn track、outliner folder、camera cut、subsequence、cinematic shot、UMG animation helper。
- Niagara：`NiagaraSystem / NiagaraEmitter / NiagaraScript` 完整 folder profile；Stack issue 读取、Quick Fix、System refresh、runtime probe、screenshot、compile log、apply 后直接返回红黄感叹号信息。
- AnimBlueprint：folder workflow、Layer Interface、Anim Layer、State Machine、Transition、图节点、预览 mesh/camera、CDO 属性写入。
- Montage：单文件 JSON workflow、slot track、segment、section、next-section、notify track/notify/notify state、Skeleton slot/group 辅助。
- Animation Assets / Skeleton：AnimSequence 信息/截图/settings/float curve JSON/bone/metadata/notify/sync marker，BlendSpace 单文件 JSON workflow，Skeleton folder workflow 覆盖 preview/compatible/socket/virtual bone/retargeting。
- SkeletalMesh：folder workflow 覆盖材质槽、mesh-only socket、physics asset、post process anim blueprint、Morph Target 删除；Morph / Skin Weight Profile 预览、Skin Weight Profile 导入/删除使用显式动作命令；raw vertex/index/skin weight/morph delta/cloth 只做摘要或导入策略，不用普通 JSON 手写。
- Deformer / ML Deformer / Geometry Cache：Geometry Cache 导入/信息/引用验证；Deformer Graph folder workflow；Source Library、Mesh Deformer Collection、ML Deformer 单文件 JSON 通过显式 `apply=true` 的属性项复用 `asset_apply_property_json`。训练和 shader compile 只走显式命令并检查插件状态、UE version、adapter 状态与日志。
- Audio：SoundWave 导入/重导入/信息读回；SoundCue folder workflow；MetaSound Source/Patch 成员 workflow；SoundAttenuation、SoundConcurrency、SoundClass、SoundMix、AudioEffectPreset 单文件 JSON；SoundSubmix folder workflow；AudioComponent/AmbientSound/AudioVolume setup validate；runtime probe、submix meter 和 submix record。AudioComponent authoring、AmbientSound/AudioVolume 放置和普通属性继续复用 Blueprint / Actor / Component / Asset Property JSON 指令。
- Texture / RenderTarget / Media：Texture 重导入、像素统计、图片导出；TextureArray/Cube/CubeArray/VolumeTexture folder workflow；RVT、RenderTarget、Media、TextureGraph、SubUV、Paper2D、TextureCollection JSON/folder workflow；RT draw/read/export/static texture 与 TextureGraph bake 依赖有效 RHI，NullRHI 下必须返回明确诊断。
- Project Settings / Config：通过 `ISettingsModule` 实时反射 Project Settings index/page，支持结构化 JSON 导出、validate/diff/apply、保存与读回；没有 Settings UObject 的自定义 UI 页返回明确 unsupported；裸 `.ini` 只走受限 `config_export_section / config_apply_section` fallback。
- IK Rig / IK Retargeter：folder workflow 覆盖 IK Rig preview/root/goal/chain/solver 和 IK Retargeter rigs/preview/settings/mapping/pose；preview solve、auto align pose、auto map 和 duplicate-retarget 属于动作命令；retarget batch 使用单文件 JSON。
- Control Rig：folder workflow 覆盖 preview、Shape Library 引用、hierarchy bones/nulls/controls/curves、variables、基础 RigVM graph node/link/pin default；Shape Library 使用单文件 JSON；runtime probe、editor view/screenshot、Sequencer bake 使用显式动作命令并检查 `binding_preflight`，未支持回写的 functions/modular/raw 等 profile 必须返回 `unsupported_apply_profile`。
- Modeling：模式激活、选择、active tool property/action、accept/cancel、primitive wrapper、mesh edit wrapper、collision/UV/material helper。

## Niagara 专项规则

- 完整 Niagara 效果制作必须走文件夹式结构化 JSON，不用零散原子命令手搓完整 System。
- 制作或修复 Niagara 视觉效果时，先读 `references/niagara-vfx-authoring.md`。先定义视觉语义、Emitter 分层、Renderer/材质、锚点、运动和生命周期，再写 JSON；不要用堆模块或堆 emitter 替代视觉设计。
- `validation/coverage_report.json` 是覆盖状态源真相；完整 profile 应为 `implementation_status=complete_folder_profile`、`is_complete_target_schema=true`、空 `pending_profiles`、空 `blocking_gaps`。
- `niagara_apply_folder` 与 `niagara_emitter_apply_folder` 默认在 apply 后编译并打开/复用 Niagara editor ViewModel 读取 Stack issue。直接检查 `stack_issue_report`、`stack_issues`、`stack_scopes`、`stack_error_count`、`stack_warning_count`、`stack_issue_view_model_source`。
- UI 红色感叹号与 compile log 不一定一致；读取 UI 同源内容时使用 `niagara_get_stack_issues(prefer_existing_view_model=true, open_editor_if_needed=true)`。
- 写入后 System 没粒子、必须手动加/删 emitter 才恢复时，先执行 `niagara_refresh_system`，再读 compile log、Stack issue 和 runtime probe。
- Collision Event / Death Event / Event Handler 这类依赖连续时间推进的效果，验证时先用 `niagara_preview_advance(reset_preview=true,target_frame=...,advance_mode=tick_component,pause_after_advance=true)` 从 0 连续 tick 到目标帧，记录返回的 `preview_state_token`；随后 `niagara_system_runtime_probe(sample_mode=current_preview,expected_preview_state_token=...,expected_frame=...)` 和 `niagara_screenshot(capture_mode=current_preview,expected_preview_state_token=...,expected_frame=...)` 只读同一暂停状态。不要让 probe 和 screenshot 各自重复推进，也不要再用 `reset_preview=false,tick_count=0` 当严格只读采样。
- Vector / Position / LinearColor 等 module input 必须使用 UE 结构化文本，例如 `(X=...,Y=...,Z=...)`、`(R=...,G=...,B=...,A=...)`，并检查写后 readback。
- Niagara module input 写入必须同时检查控制分支。`mode / enum / static switch` 决定哪个输入真正生效；例如非均匀 Sprite 必须读回 `Sprite Size Mode=Non-Uniform`，再确认 `Module.Sprite Size`。只读到目标值存在不等于运行时使用它。
- Renderer 是视觉行为的一部分。Sprite / Mesh / Ribbon / Light 的选择必须服务于主形体和数据流；材质、贴图、SubUV、opacity、emissive、pivot 和 binding 都要纳入验收，不要只看粒子数量。
- Niagara Data Interface 的曲线 raw property 必须用 folder workflow 的 `curve_json` 修改。System apply 会在总刷新后回写 DataInterface，检查 `post_refresh_data_interfaces_applied` 和重新 export 的 `data_interfaces.json`，不要只看 apply 前的旧 graph 对象。
- Niagara Module Input 的 Dynamic Input 也必须用 folder JSON 表达：编辑 `modules[].inputs[].dynamic_input`、`dynamic_input.inputs[]` 和 `dynamic_input.data_interfaces[].raw_properties[].curve_json`。不要再用 `niagara_emitter_set_module_input` 的 Dynamic Input 扩展参数做 authoring 或普通修补；该扩展只保留旧脚本兼容和极端故障恢复。
- 写入前必须确认该 mode 对应的有效属性组；apply 后重新 export 并按当前 mode 校验对应字段。例如 `Uniform` 校验 `Uniform Sprite Size`，`Non-Uniform` 校验 `Sprite Size`。非当前 mode 的字段即使读回存在，也不得视为生效。
- `module_input_hidden_or_inactive_branch` 不得当作噪声忽略；它表示写入可能落在非活跃分支。遇到它时先设置控制项，重新 apply/export/readback，再写分支值。
- 枚举型输入不能只看 `NewEnumeratorN`；必须结合导出的 `enum_value_display_name`、`override_enum_value_display_name` 和 `enum_options[]` 判断 UI 语义。
- Collision 相关效果优先使用默认 Ray Trace collision；碰撞后生成粒子应通过 Event Handler 接收碰撞事件，在事件 payload 位置生成，不要用静态位置假冒。
- 事件、碰撞、命中、尾迹和后续爆裂必须验证 payload 位置、速度、法线和时间推进；截图和 runtime probe 只能作为证据之一，不能替代 Stack、compile、readback、Renderer/material 检查。
- Event Handler 中不要无意义重复 `Initialize Particle` 覆盖事件 payload。`Kill Particles` 不应清理承载给后续事件的变量。
- UE 崩溃后第一优先级是找根因并修复指令/数据路径，不继续堆绕路操作。

## Control Rig / 动画 IK 专项规则

- 制作或修复运行时 IK 前先读 `references/control-rig-animation-authoring.md`，把问题拆成 Control Rig 求解、AnimBlueprint 接入、动画曲线权重、碰撞/Trace 语义四层分别验证。
- Control Rig authoring 走 `control_rig_export_folder -> 修改 folder JSON -> control_rig_validate_folder -> control_rig_apply_folder -> export/readback`；替换求解图时使用导出的真实 graph 模板，并检查 `replace_nodes`、`compile_report`、`readback` 和 `issues[]`。
- AnimBlueprint 接入 Control Rig 不由 `control_rig_apply_folder` 隐式完成；必须通过 `anim_blueprint_export_folder / anim_blueprint_apply_folder` 验证 `Node.ControlRigClass`、`Node.DefaultControlRigClass`、`Node.bExecute` 和输入/输出 Pose 同步设置。
- IK Trace 必须先确认目标 RigVM unit 的空间语义、Trace channel/object types、自身过滤、no-hit fallback 和运行时权重。截图只能辅助判断，不能替代 compile、readback、probe、曲线回读和碰撞查询。
- Control Rig Shape Library 只影响编辑器控制形状的显示，不参与求解、不改变运行时 IK 逻辑。

## 编辑器会话与关闭卫生

- 优先连接当前 editor；如果已有 editor，先 `doctor`。
- 通过项目 task 或 `scripts/ue/RunEditor.ps1` 拉起 GUI editor 时默认最小化且不抢焦点；默认只在启动瞬间最小化一次，不持续压回 UE 窗口。只有用户明确要求旧行为时才传 `-EnableMinimizeWatchdog`。
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

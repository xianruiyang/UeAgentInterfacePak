# Audio 指令

本分册覆盖 `UeAgentInterface` 的 Audio 专用资产与运行时验证命令。Audio 指令只补通用 Actor、Blueprint、Component、Asset Property JSON 无法安全表达的音频结构：SoundWave 导入、SoundCue 图、MetaSound 成员、SoundClass/SoundMix/Attenuation/Concurrency、Submix/Effect chain，以及运行时 audio probe。

## 边界

- SoundWave 浅层设置继续使用 `asset_export_property_json / asset_apply_property_json`，例如 SoundClass、Attenuation、Concurrency、loading/compression 普通属性；Audio 分册只提供导入、重导入、信息读回、语义校验和预览。
- `AudioComponent` 创建、挂载和默认属性继续使用 Blueprint/Actor/Component 指令；Audio 分册只提供 setup validate、runtime snapshot 和 runtime probe。
- `AAmbientSound`、`AAudioVolume` 的创建、transform、folder、tag 继续使用 Actor/Level 指令；Audio 分册只提供语义校验。
- Sequencer 音频轨道属于 `06_Sequence.md` 的结构扩展，不在本分册新增重复命令。
- 运行时命令在 NullRHI、headless 或没有真实 Audio Device 时必须返回明确的 `audio_device_unavailable`，不能伪造成功。

## SoundWave

| 指令 | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `sound_wave_import` | 从音频源文件导入 `USoundWave` | `source_file`、`destination_path`、`destination_name`、`replace_existing`、`save_after_import` | `asset_path`、`duration`、`sample_rate`、`channels`、`source_file` |
| `sound_wave_reimport` | 重导入已有 SoundWave | `asset_path`、`source_file`、`save_after_reimport` | `reimported`、`duration_before`、`duration_after` |
| `sound_wave_get_info` | 读取 SoundWave 摘要 | `asset_path`、`include_properties`、`include_cue_points`、`include_analysis` | `duration`、`sample_rate`、`channels`、`loading_behavior`、`sound_class` |
| `sound_wave_validate_setup` | 校验 SoundWave 语义配置 | `asset_path`、`expected_sound_class`、`expected_attenuation`、`expected_concurrency[]`、`strict` | `status`、`json_issues[]`、`readonly_info` |
| `sound_wave_preview` | 预览 SoundWave 并采样 | `asset_path`、`duration`、`volume`、`expected_min_peak`、`stop_after_preview` | `started`、`stopped`、`probe_passed`、`peak_envelope` |

导入走 UE `USoundFactory` / reimport 路径，不手写 `.uasset`，不通过 JSON 修改 PCM 原始采样数据。

## SoundCue

| 指令 | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `sound_cue_create` | 创建空 SoundCue | `asset_path`、`replace_existing`、`save_after_create` | `asset_path`、`created_asset` |
| `sound_cue_get_info` | 读取 SoundCue 图摘要 | `asset_path`、`include_nodes`、`include_properties`、`include_validation` | `nodes[]`、`edges[]`、`root_node_id` |
| `sound_cue_export_folder` | 导出 folder JSON | `asset_path`、`folder_path`、`clean_output_dir`、`include_raw_properties`、`include_validation` | `files[]`、`coverage_report` |
| `sound_cue_validate_folder` | 只读校验 folder | `folder_path`、`asset_path`、`strict` | `status`、`json_issues[]`、`coverage_report` |
| `sound_cue_apply_folder` | 回写 SoundCue 图 | `folder_path`、`asset_path`、`create_if_missing`、`dry_run`、`validate_only`、`allow_destructive`、`save_after_apply` | `nodes_created`、`edges_created`、`property_results[]` |
| `sound_cue_open_editor` | 打开 SoundCue 编辑器 | `asset_path`、`bring_to_front` | `opened` |
| `sound_cue_screenshot` | 截取 SoundCue 图诊断图 | `asset_path`、`format`、`max_size`、`require_non_black` | `file_path`、`appears_non_black` |
| `sound_cue_preview` | 预览 SoundCue 并采样 | `asset_path`、`duration`、`parameters{}`、`expected_min_peak` | `started`、`probe_passed`、`peak_envelope` |

`sound_cue_open_editor` 在 commandlet、unattended、headless 等无可用编辑器 UI 的场景不会强行打开 Slate 资产编辑器，会返回 `opened=false` 和 `skipped_reason=headless_editor_ui_unavailable`，避免自动化退出阶段的布局保存崩溃。

SoundCue folder 文件：

```text
asset.json
nodes.json
edges.json
parameters.json
layout.json
raw_properties.json
validation/coverage_report.json
validation/issues.json
```

`sound_cue_apply_folder` 支持常用 `USoundNode`：`wave_player`、`random`、`mixer`、`modulator`、`continuous_modulator`、`delay`、`looping`、`concatenator`、`distance_crossfade`、`param_crossfade`、`switch`、`branch`、`attenuation`、`sound_class`、`enveloper`、`doppler`、`quality_level`、`wave_param`、`dialogue_player`。未知节点类会失败返回 `unsupported_node_type`。已有节点图被重建时必须显式传 `allow_destructive=true`。

## MetaSound

| 指令 | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `metasound_create` | 创建 MetaSound Source 或 Patch | `asset_path`、`asset_type=source|patch`、`save_after_create` | `asset_path`、`asset_type`、`created_asset` |
| `metasound_get_info` | 读取 MetaSound 摘要 | `asset_path`、`include_graph`、`include_interfaces`、`include_validation` | `inputs[]`、`outputs[]`、`nodes[]`、`compile_report` |
| `metasound_export_folder` | 导出 folder JSON | `asset_path`、`folder_path`、`clean_output_dir`、`include_raw_properties`、`include_validation` | `files[]`、`coverage_report` |
| `metasound_validate_folder` | 只读校验 folder | `folder_path`、`asset_path`、`strict` | `status`、`json_issues[]`、`unsupported_nodes[]` |
| `metasound_apply_folder` | 回写 MetaSound 成员 | `folder_path`、`asset_path`、`create_if_missing`、`dry_run`、`validate_only`、`compile_after_apply`、`save_after_apply` | `nodes_created`、`edges_created`、`compile_report` |
| `metasound_compile` | 编译 MetaSound | `asset_path`、`include_messages`、`save_after_compile` | `error_count`、`warning_count`、`messages[]` |
| `metasound_open_editor` | 打开 MetaSound 编辑器 | `asset_path`、`bring_to_front` | `opened` |
| `metasound_screenshot` | 生成 MetaSound 图诊断图 | `asset_path`、`target`、`format`、`max_size`、`require_non_black` | `file_path`、`appears_non_black` |
| `metasound_preview` | 预览并设置输入参数 | `asset_path`、`duration`、`inputs{}`、`expected_min_peak` | `started`、`probe_passed`、`peak_envelope` |

`metasound_open_editor` 与 SoundCue 相同，在 headless 自动化中返回跳过状态而不是打开 UI；`metasound_apply_folder` 使用 `UMetaSoundEditorSubsystem::FindOrBeginBuilding` 取得资产 builder，写回后注册 graph，不使用只能覆盖 transient MetaSound 的 `BuildAndOverwriteMetaSound`。

`metasound_apply_folder` 默认 `compile_after_apply=true`。apply 会在最终保存前调用 `metasound_compile(save_after_compile=false)`，响应中的 `compile_report` 来自这次 apply 内编译触发；当前 MetaSound 编译接口只能返回空 `messages[]`、`error_count=0` 的刷新型报告，不能像 Blueprint/Material/Niagara 一样作为可阻断错误日志源。`save_after_apply=true` 只会在 apply 和 compile 调用成功后执行。

MetaSound folder 文件：

```text
asset.json
interfaces.json
members/inputs.json
members/outputs.json
members/variables.json
graphs/root.json
graphs/nodes.json
graphs/edges.json
graphs/literals.json
layout.json
settings.json
raw_properties.json
validation/coverage_report.json
validation/issues.json
```

当前 MetaSound apply 以安全成员 authoring 为边界：支持 graph input/output 成员创建与默认值回写；`graphs/nodes.json` 中出现非 `graph_input`、`graph_output`、`comment` 的节点类型时会硬失败，不会静默跳过 native/plugin/custom DSP 节点。复杂 DSP 图应先导出保真摘要，再在后续扩展中以显式节点支持进入 apply。

## Mix 与空间化 JSON

| 指令 | 作用 |
| --- | --- |
| `sound_attenuation_create` | 创建 `USoundAttenuation` |
| `sound_attenuation_get_info` | 读取 spatialization、distance attenuation、occlusion、reverb/submix send 摘要 |
| `sound_attenuation_export_json` | 导出 Attenuation 单文件 JSON |
| `sound_attenuation_validate_json` | 校验 Attenuation JSON |
| `sound_attenuation_apply_json` | 回写 Attenuation JSON，支持 `dry_run`、`validate_only`、`create_if_missing` |
| `sound_concurrency_create` | 创建 `USoundConcurrency` |
| `sound_concurrency_get_info` | 读取 MaxCount、ResolutionRule 等并发规则 |
| `sound_concurrency_export_json` | 导出 Concurrency JSON |
| `sound_concurrency_validate_json` | 校验 Concurrency JSON |
| `sound_concurrency_apply_json` | 回写 Concurrency JSON |
| `sound_class_create` | 创建 `USoundClass` |
| `sound_class_get_info` | 读取 SoundClass 属性、parent、children |
| `sound_class_export_json` | 导出 SoundClass JSON |
| `sound_class_validate_json` | 校验 SoundClass JSON |
| `sound_class_apply_json` | 回写 SoundClass JSON |
| `sound_mix_create` | 创建 `USoundMix` |
| `sound_mix_export_json` | 导出 SoundMix JSON |
| `sound_mix_apply_json` | 回写 SoundMix JSON 和 `sound_class_effects[]` |

`sound_attenuation_apply_json` 支持设计文档中的语义字段 `attenuation{}`、`spatialization{}`、`occlusion{}`，并继续支持 `properties[]` raw property round-trip；导出 JSON 中的 `attenuation` 摘要只会按已知语义键回写，身份字段如 `asset_path`、`class` 会被忽略。

这些命令复用统一属性写入诊断：`property_results[]`、`requested_value_text`、`property_value_read_back`、`property_import_status`、`dry_run`、`would_create`。

## Submix 与 Effect Preset

| 指令 | 作用 | 关键参数 |
| --- | --- | --- |
| `sound_submix_create` | 创建 Submix | `asset_path`、`submix_class`、`save_after_create` |
| `sound_submix_get_info` | 读取 parent/children/effect chain | `asset_path`、`include_children`、`include_effect_chain` |
| `sound_submix_export_folder` | 导出 Submix folder | `asset_path`、`folder_path`、`clean_output_dir` |
| `sound_submix_validate_folder` | 校验 folder 必需文件 | `folder_path`、`strict` |
| `sound_submix_apply_folder` | 回写 parent 与 effect chain | `folder_path`、`asset_path`、`create_if_missing`、`dry_run`、`validate_only`、`save_after_apply` |
| `audio_effect_preset_create` | 创建 Source/Submix effect preset | `asset_path`、`preset_class`、`save_after_create` |
| `audio_effect_preset_export_json` | 导出 preset JSON | `asset_path`、`output_file` |
| `audio_effect_preset_apply_json` | 回写 preset JSON | `json_file`、`asset_path`、`create_if_missing`、`dry_run`、`validate_only` |

Submix folder 文件：

```text
asset.json
graph.json
effects.json
raw_properties.json
validation/coverage_report.json
validation/issues.json
```

## 场景与运行时验证

| 指令 | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `audio_component_validate_setup` | 校验场景中的 AudioComponent | `actor`、`component_name`、`expected_sound` | `status`、`json_issues[]`、组件 snapshot |
| `audio_component_runtime_snapshot` | 读取 AudioComponent 播放状态 | `actor`、`component_name` | `is_playing`、`sound`、`volume_multiplier` |
| `audio_component_runtime_probe` | 播放/采样已有组件 | `actor`、`component_name`、`duration`、`expected_min_peak` | `probe_passed`、`peak_envelope`、`cleanup_results[]` |
| `audio_volume_validate_setup` | 校验 `AAudioVolume` | `actor` | `status`、`json_issues[]` |
| `ambient_sound_validate_setup` | 校验 `AAmbientSound` | `actor`、`expected_sound` | `status`、`json_issues[]` |
| `audio_runtime_snapshot` | 聚合 Audio Device、active sounds、components | `include_active_sounds`、`include_components`、`include_submixes` | `audio_device_available`、`active_sound_count` |
| `audio_runtime_probe` | 临时播放指定 `USoundBase` 并采样 | `sound`、`location`、`duration`、`expected_min_peak`、`cleanup` | `started`、`stopped`、`probe_passed`、`peak_envelope` |
| `audio_submix_meter_probe` | 采样 Submix meter | `submix`、`duration`、`frequencies[]`、`expected_min_peak` | `peak_by_channel[]`、`spectrum[]` |
| `audio_submix_record_start` | 开始 Submix 录制 | `submix`、`recording_id/session_id`、`name`、`path`、`expected_duration` | `recording_id`、`session_id`、`started` |
| `audio_submix_record_stop` | 停止录制并导出 | `recording_id/session_id`、`export_type=wav|wav_file|sound_wave`、`output_path`、`asset_path` | `exported_file`、`asset_path`、`duration` |
| `audio_submix_record_cancel` | 停止录制并丢弃导出文件 | `recording_id/session_id` | `canceled`、`deleted_file_count`、`elapsed` |
| `audio_stop_all_preview_sounds` | 停止 UAI 创建的预览/探针组件 | `scope=current_uai|all_preview` | `stopped_count` |

## 截图与测试契约

- `sound_cue_screenshot`、`metasound_screenshot` 使用离屏诊断图，不依赖 viewport backbuffer；返回 `appears_non_black`。
- Runtime probe 默认 cleanup，并通过 `audio_stop_all_preview_sounds` 做兜底清理。
- 自动化覆盖入口：`GptProjectTest.UeAgentInterface.Smoke.AudioCommands`。

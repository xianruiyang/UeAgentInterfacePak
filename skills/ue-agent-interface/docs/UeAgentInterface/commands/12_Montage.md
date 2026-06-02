# 指令详解：Montage

> 废弃写入命令已迁移到 `deprecatedCommand/12_Montage.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## 资产与基础信息

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `montage_list_montages` | 列出 Montage 资产 | `root_path`、`limit` | 先查是否已有目标 Montage |
| `montage_create` | 创建 Montage 资产 | `asset_path`、`target_skeleton` 或 `source_animation`、可选 `preview_skeletal_mesh`、`open_editor`、`save_after_create` | 新建技能或动作 Montage |
| `montage_open_editor` | 打开 Montage 编辑器 | `asset_path` | 进入 Persona / Montage 编辑上下文 |
| `montage_get_info` | 读取 Montage 信息 | `asset_path` | 查看 slot、segment、section、notify、blend 配置 |
| `montage_export_json` | 导出单文件 JSON 真源 | `asset_path`；可选 `output_file` | 当前推荐的 Montage 主编辑工作流入口 |
| `montage_apply_json` | 从单文件 JSON 回写 Montage | `json_file` 或内联 JSON；可选 `create_if_missing`、`save_after_apply` | 读取 JSON 后重建结构并回写资产 |
| `montage_list_skeleton_slots` | 列出 Skeleton 上的 Slot/Group | `skeleton_path` 或 `asset_path` | 对照 Montage slot 与 Skeleton slot group |

### `montage_create`

- 如果传了 `source_animation`，会直接用它初始化默认 slot 的第一段 segment。
- 如果没传 `source_animation`，则必须显式提供 `target_skeleton`。
- `preview_skeletal_mesh` 会做 skeleton 兼容性检查。

### `montage_get_info`

返回：
- `skeleton`
- `preview_skeletal_mesh`
- `first_animation_reference`
- `sequence_length`
- `slot_track_count`
- `section_count`
- `segment_total_count`
- `blend_in_time / blend_out_time / blend_out_trigger_time`
- `enable_auto_blend_out`
- `blend_mode_in / blend_mode_out`
- `sync_group_name`
- `sync_enabled`
- `sync_slot_index / sync_slot_name / sync_slot_valid`
- `can_use_marker_sync`
- `sync_marker_count`
- `slot_tracks[]`
- `sections[]`
- `notify_tracks[]`
- `notifies[]`
- `sync_markers[]`

`slot_tracks[].segments[]` 当前会返回：
- `segment_index`
- `animation_asset`
- `start_pos`
- `anim_start_time / anim_end_time`
- `play_rate`
- `loop_count`
- `segment_length`
- `skeleton_slot_registered`
- `skeleton_group_name`

`sections[]` 当前会返回：
- `section_index`
- `section_name`
- `time_seconds`
- `next_section_name`
- `slot_index`
- `segment_index`

`notify_tracks[]` 当前会返回：
- `track_index`
- `track_name`
- `track_color`
- `track_color_linear`
- `notify_count`

`notifies[]` 当前会返回：
- `notify_index`
- `notify_name`
- `track_name / track_index`
- `time_seconds / trigger_time_seconds / duration_seconds`
- `is_state`
- `branching_point`
- `tick_type`
- `trigger_weight_threshold`
- `notify_trigger_chance`
- `notify_filter_type / notify_filter_lod`
- `can_be_filtered_via_request`
- `trigger_on_dedicated_server`
- `trigger_on_follower`
- `notify_color`
- `notify_color_linear`
- `notify_class / notify_state_class`
- `guid`

`sync_markers[]` 当前会返回：
- `marker_index`
- `marker_name`
- `time_seconds`
- `track_index / track_name`
- `guid`

## JSON 工作流

- `montage_export_json / montage_apply_json`
  - 这是 `AnimMontage` 当前推荐的主编辑路径。
  - `Montage` 本身是“单资产、强时间轴、结构层级有限”的对象，当前更适合单文件 JSON，而不是文件夹式结构。
  - 导出 JSON 根字段当前稳定包含：
    - `schema`
    - `format_version`
    - `asset_kind`
    - `asset_path / asset_name`
    - `skeleton`
    - `preview_skeletal_mesh`
    - `settings`
    - `sync`
    - `slot_tracks`
    - `sections`
    - `notify_tracks`
    - `notifies`
    - `sync_markers`
    - `skeleton_slots`
  - `apply_json` 当前会按“先补缺口、再删多余、最后重建内容”的顺序处理 slot track / notify track，避免因为 UE 不允许删除最后一个 slot track 或 notify track 而中途失败。
  - `json_file` 文件缺失、读取失败或 JSON 语法解析失败会直接失败返回 `json_file_not_found / load_json_file_failed / json_parse_failed`。
  - `sections[]` 不要求一定存在 `Default` section；对已经重命名首段的 Montage，导出 JSON 再回写应保持命名 section 链路并成功 round-trip。
  - 返回包含 `warning_count / warnings`；`skeleton_slots / slot_tracks / segments / sections / notify_tracks / notifies` 中不是 object 或缺关键字段的可恢复条目会写入 warnings，不再静默跳过。
  - 推荐方法：
    1. `montage_create`
    2. `montage_export_json`
    3. 编辑 JSON
    4. `montage_apply_json`
    5. `montage_get_info`
    6. 必要时 `save_asset`

## Marker Sync

说明：
- UE 5.6 的 Montage marker sync 不是在 Montage 上直接手写 markers；Montage 只配置 `SyncGroup / SyncSlotIndex`，实际 marker 数据来自底层 `AnimSequence` 并汇总到 `MarkerData`。
- `sync_group_name` 传空字符串时，会清空当前 Montage 的 sync group。
- `sync_slot_name` 和 `sync_slot_index` 二选一即可；都不传时会复用当前 Montage 的 `SyncSlotIndex`，若当前无效则退回 `0` 号 slot。
- `montage_get_info` 返回的 `sync_markers[]` 是 Montage 当前汇总后的 marker 结果，不是 Skeleton slot 配置。

## Notify / Branching Point

> 废弃写入命令已迁移到 `deprecatedCommand/12_Montage.md` 的对应章节。

说明：
- Notify JSON 传 `notify_name` 时会走命名 notify；传 `notify_class` 时会创建 class-based notify。
- Notify State JSON 目前要求 `notify_state_class` 是可实例化的具体类。
- `tick_type` 支持 `queued / branching_point`；如果同时传了 `branching_point`，优先以 `tick_type` 为准。
- `branching_point=true` 是 `tick_type=branching_point` 的兼容写法。
- `track_color / notify_color` 推荐传 `{r,g,b,a}`；支持 `0..1` 浮点，也兼容 `0..255` 数值输入。
- 现有 notify 命令已经支持 `TriggerWeightThreshold / NotifyTriggerChance / NotifyFilterType / NotifyFilterLOD / bCanBeFilteredViaRequest / bTriggerOnDedicatedServer / bTriggerOnFollower` 这组 UE 5.6 常用触发设置。
- 删除 notify track 目前只允许删除空 track，不会隐式连带删 notify。

## Skeleton Slot / Group

说明：
- UE 里的 Montage slot 最终要落到 Skeleton 的 slot/group 配置上，分层动画和并行 montage 才有稳定语义。
- 当前命令把这层显式拆出来，避免只改 Montage 资产本身却忘了 Skeleton 配置。
- `montage_list_skeleton_slots` 支持两种入口：
  - `skeleton_path`
  - `asset_path`（从 Montage 反查 Skeleton）
- `save_skeleton=false` 时只会修改当前 Editor 会话内的 Skeleton 资产，不会落盘。

## Slot Track

> 废弃写入命令已迁移到 `deprecatedCommand/12_Montage.md` 的对应章节。

说明：
- 当前只允许删除“最后一个且没有 segment 的 slot track”，避免破坏现有 section/linkable 索引。

## Segment

> 废弃写入命令已迁移到 `deprecatedCommand/12_Montage.md` 的对应章节。

说明：
- `animation_asset` 当前接受 `UAnimSequenceBase`。
- 会做 skeleton 兼容性检查。
- `start_pos` 是 Montage 里的绝对时间位置，不是段内偏移。
- `anim_start_time / anim_end_time` 是源动画里的截取范围。

## Section

> 废弃写入命令已迁移到 `deprecatedCommand/12_Montage.md` 的对应章节。

说明：
- 当前不允许删除最后一个 section。
- `clear_next_section=true` 时会清空下一段。

## 推荐流程

主路径：

1. `montage_create`
2. `montage_export_json`
3. 编辑单文件 JSON
4. `montage_apply_json`
5. `montage_get_info`
6. `save_asset`

所有 slot track、segment、section、notify 和 sync 配置都应写入单文件 JSON 后通过 `montage_apply_json` 回写；旧逐条写入流程仅保留在废弃分册。

## 当前边界

- 当前已落地单文件 JSON 工作流，但 `AnimMontage` 还不是 UE5.6 Persona 全覆盖；`child montage / time stretch / 更完整 notify payload` 仍偏设计口径或原子命令辅助口径。
- 当前已支持基础 notify track / notify / notify state / branching point 标记、颜色，以及一组常用触发/过滤设置，但还没有 notify payload、notify class 具体属性的细粒度编辑命令。
- 当前已支持 Montage marker sync 的 Group/Slot 配置与汇总结果回读，但还没有直接改写底层 `AnimSequence` sync markers 的命令；这层应由动画序列侧单独管理。
- 当前已支持基础 Skeleton slot/group 管理，但还没有“同步修改 Montage slot track + Skeleton slot 名称”的一体化事务命令。
- 当前还没有 slot track 中段级重排、section 批量重排、曲线与 metadata 编辑命令。
- 当前重点是“资产级 + 结构级 + 基础播放配置”，不是 Persona 全量替代。

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/12_Montage.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。

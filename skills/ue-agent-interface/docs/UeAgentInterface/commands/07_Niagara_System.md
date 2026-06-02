# 指令详解：Niagara（System / Asset / User Parameter）

> 废弃写入命令已迁移到 `deprecatedCommand/07_Niagara_System.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## 资产级操作

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_list_assets` | 列出 Niagara 资产 | `root_path`、`limit` | 枚举测试目录资产 |
| `niagara_create_system` | 创建 Niagara System | `asset_path`、`create_default_nodes`、`open_editor` | 新建 NS 测试资产 |
| `niagara_create_emitter` | 创建 Niagara Emitter | `asset_path`、`add_default_modules_and_renderers` | 新建独立 Emitter 资产 |
| `niagara_delete_asset` | 删除 Niagara 资产 | `asset_path`、`force_delete`、`use_unchecked_delete` | 清理 AutoTests 临时资产 |
| `niagara_duplicate_asset` | 复制 Niagara 资产 | `source_asset_path`、`target_asset_path` | 基于模板快速变体 |
| `niagara_open_editor` | 打开 Niagara 资产编辑器 | `asset_path` | 进入编辑上下文 |
| `niagara_preview_advance` | 连续推进 Niagara 编辑器预览并暂停 | `asset_path`、`target_frame`、`tick_delta_seconds` | 从 0 连续 tick 到指定帧，供后续 probe / screenshot 只读采样 |
| `niagara_screenshot` | 截取 Niagara 资产编辑器界面，支持从 0 连续推进的序列帧总览图 | `asset_path`、`target`、`format`、`max_size`、`open_editor_if_needed`、`target_frame`、`start_frame_index`、`count`、`frame_interval`、`preview_tick_delta_seconds`、`frame_capture_renderer`、`camera_fov`、`camera_distance_scale`、`create_frame_sheet`、`write_individual_frames`、`frame_sheet_padding`、`frame_sheet_max_size`、`frame_sheet_label_scale` | 调试 Niagara 编辑器预览/栈面板是否真实写入 |
| `niagara_system_runtime_probe` | 读取 System 预览组件运行统计 | `asset_path`、`tick_count`、`advance_mode` | 不开 PIE 地验证 System 是否实际产生活粒子 |
| `niagara_get_info` | 读取 Niagara 资产概况 | `asset_path` | 查看 System/Emitter 结构 |
| `niagara_get_stack_issues` | 读取 Niagara Stack 红/黄/信息提示 | `asset_path`、`severity_filter`、`open_editor_if_needed` | 获取 System 或 Emitter 栈面板感叹号内容 |
| `niagara_apply_stack_issue_fix` | 应用 Stack issue 提供的修复项 | `asset_path`、issue selector、`fix_index` | 对 UI 红色感叹号执行 UE 提供的 Quick Fix |
| `niagara_refresh_system` | 强制刷新 System 结构状态 | `asset_path`、`compile_after_refresh`、`save_after_refresh` | 修复写入后 overview / emitter execution / compiled data 过期 |

> 安全说明：`niagara_create_system` 的 `create_default_nodes=false` 会创建最原始的 System 资产，SystemSpawn/SystemUpdate 图可能没有 Niagara 输出节点。这种资产可以用于底层结构测试，但不能直接打开 Niagara 编辑器或运行 `niagara_system_runtime_probe`。相关命令现在会在打开编辑器前返回 `unsafe_niagara_system_graph_missing_output_nodes`，避免 UE 在 Niagara Stack 构建阶段崩溃。需要从“空 System”开始做可运行效果时，应使用 `create_default_nodes=true` 创建最小有效 System 图，再手动添加 Emitter、Module 和 Renderer；这不是复制模板。

### `niagara_delete_asset`

用于删除 Niagara System / Emitter / Script。`force_delete=true` 会使用无确认删除路径；当目标包尚未落盘，或显式传 `use_unchecked_delete=true` 时，会走 `delete_objects_unchecked`，避免临时 NiagaraScript 等未保存资产在 UE 的递归引用替换路径中长时间阻塞 UAI 服务。删除返回成功后会清理同路径残留的非公开/非 standalone UObject，避免同一编辑器会话内立刻重建时报 `asset_already_exists`。

关键参数：

- `asset_path`：必填，Niagara 资产路径。
- `force_delete`：可选，默认 `false`；测试清理和临时资产删除建议传 `true`。
- `use_unchecked_delete`：可选，默认 `false`；强制使用 unchecked 删除路径。未落盘资产会自动启用该路径。

返回字段包含 `deleted_asset_path`、`deleted_object_path`、`asset_kind`、`force_delete`、`package_exists_on_disk`、`use_unchecked_delete`、`delete_strategy`、`found_residual_object_after_delete`、`detached_residual_object_after_delete`。

### `niagara_preview_advance`

用于控制 Niagara System 编辑器预览组件从指定起点连续推进到目标帧，并在目标帧暂停。该命令只操作 Niagara 编辑器预览组件，不启动 PIE / game 窗口。对 Collision Event / Death Event / Event Handler 效果，推荐先用本命令连续 tick 到目标帧，再用 `niagara_system_runtime_probe(sample_mode=current_preview)` 和 `niagara_screenshot(capture_mode=current_preview)` 只读同一暂停状态。

关键参数：

- `asset_path`：必填，Niagara System 资产路径。
- `open_editor_if_needed`：可选，默认 `true`；为 `false` 时只复用已打开的 Niagara 编辑器。
- `reset_preview`：可选，默认 `true`；为 `true` 时从 0 帧开始连续推进。
- `start_frame`：可选，默认 `0`；`reset_preview=true` 时必须为 `0`。
- `target_frame` / `frame` / `advance_frames` / `preview_advance_frames`：可选其一，目标帧。若未提供，可用 `target_time_seconds` / `preview_advance_seconds` 按 `tick_delta_seconds` 换算。
- `tick_delta_seconds` / `preview_tick_delta_seconds`：可选，默认约 `1/60`。
- `advance_mode` / `preview_advance_mode`：可选，默认 `tick_component`；也支持 `advance_simulation`，但事件/碰撞类效果优先使用 `tick_component`。
- `pause_after_advance` / `pause_preview_after_advance`：可选，默认 `true`。

返回字段包含：

- `preview_state_token`：本次暂停状态的令牌。后续只读 probe / screenshot 应传入 `expected_preview_state_token`，防止读到另一套预览状态。
- `target_frame`、`advanced_frame_count`、`tick_delta_seconds`、`system_age`、`current_frame_estimate`。
- `advance_semantics`：`continuous_from_zero` 或 `continuous_from_current`。
- `used_seek=false`：确认没有使用 seek / 直接跳时间轴。
- `stats`：目标帧暂停后的当前组件统计。

45 帧截图和 probe 的推荐流程：

```json
{
  "command": "niagara_preview_advance",
  "params": {
    "asset_path": "/Game/Niagara/NS_UAI_Rain_HighQuality",
    "open_editor_if_needed": true,
    "reset_preview": true,
    "target_frame": 45,
    "tick_delta_seconds": 0.016667,
    "advance_mode": "tick_component",
    "pause_after_advance": true
  }
}
```

记录返回的 `preview_state_token` 后，再调用只读 probe 和截图。

### `niagara_screenshot`

用于打开或复用 Niagara System / Emitter / Script 编辑器，并把编辑器界面或预览画面截图写入 UAI artifacts `Shots` 目录。该命令不运行 PIE / game。

当传入 `target_frame`、`frame_index`、`start_frame_index`、`count`、`frame_interval` 或 `frames[]` 时，`niagara_screenshot` 会进入序列帧模式。该模式仅支持 Niagara System：命令会重置预览到 0 帧，使用 `tick_component` 或 `advance_simulation` 从 0 连续推进，并在请求帧暂停截图。多帧请求在同一次连续推进中完成，避免外部脚本反复执行 `niagara_preview_advance + niagara_screenshot` 两条命令。序列帧默认使用 `preview_scene_capture`，直接拍摄同一预览组件所在 preview world，避免 Slate 离屏绘制只得到静态 UI 背景。多帧模式默认只输出一张序列帧总览图，方便像动画选帧图一样一次查看完整阶段；每个格子左上角标注 `F<frame_index>`。

关键参数：

- `asset_path`：必填，Niagara 资产路径。
- `target`：可选，`window` 默认，截完整 Niagara 编辑器窗口；`viewport` / `preview` 截预览视口区域。
- `open_editor_if_needed`：可选，默认 `true`；为 `false` 时只复用已经打开的编辑器。
- `format`：可选，`png` 默认，也支持 `jpg` / `webp`。
- `quality`：可选，`jpg` / `webp` 压缩质量，范围 `1..100`。
- `max_size`：可选，最长边，默认 `2048`。
- `file_path` / `out_file_path`：可选，自定义输出路径；相对路径按项目根目录解析。
- `offscreen` / `use_offscreen_renderer`：兼容参数；非序列帧 UI 截图使用 Slate 离屏绘制路径，避免依赖真实窗口 backbuffer。
- `frame_capture_renderer` / `capture_renderer` / `renderer`：序列帧模式可选，默认 `preview_scene_capture`；可显式传 `slate_widget_offscreen` 走旧 Slate 兼容路径。
- `create_frame_sheet` / `frame_sheet` / `sequence_frame_image`：多帧序列帧模式可选，默认 `true`；为 `false` 时不输出合成总览图。
- `write_individual_frames` / `keep_individual_frames` / `output_individual_frames`：多帧序列帧模式可选，默认 `false`；为 `true` 时在总览图之外额外写出每帧单图，并在 `frames[].file_path` 返回路径。
- `frame_sheet_padding` / `sheet_padding`：可选，总览图帧间距，默认 `8` 像素。
- `frame_sheet_max_size` / `sheet_max_size`：可选，总览图最长边，默认 `8192`。
- `frame_sheet_label_scale` / `sheet_label_scale`：可选，总览图帧号字号，默认 `3`。
- `wait_for_render_dependencies` / `wait_for_asset_compilation` / `wait_for_shader_compilation`：序列帧 `preview_scene_capture` 可选，默认 `true`。第一帧真实截图前会提交当前预览 world 的材质剩余编译任务、等待资产/Shader 编译并做一次 SceneCapture warmup，避免刚重启编辑器或首次加载材质时把未编译完成的透明粒子截成黑图。
- `scene_capture_warmup_captures` / `render_warmup_captures`：序列帧 `preview_scene_capture` 可选，默认 `1`，范围 `0..8`；只在第一帧正式截图前执行 warmup capture。
- `reset_preview`：可选；只有 `true` 或设置 `preview_advance_seconds > 0` 时才会准备 Niagara 预览组件。显式传 `false` 不会触发预览重置或真实窗口 redraw。
- `preview_advance_seconds` / `preview_tick_delta_seconds` / `preview_advance_mode`：可选，用于截图前推进 Niagara 编辑器预览；不需要推进时不要传。
- `target_frame` / `frame_index` / `frame`：可选，序列帧模式的单帧目标；从 0 连续 tick 到该帧后截图。
- `start_frame_index` / `count` / `frame_interval`：可选，序列帧模式的批量帧定义；最多 120 张。
- `frames[]`：可选，显式帧列表。数组项可为数字，或 `{ "frame_index": 45 }` / `{ "target_frame": 45 }`。当前列表必须非递减，以便一次从 0 连续推进完成。
- `capture_mode=current_preview`：只截图当前已暂停的 preview 状态，不 reset、不 activate、不 tick。应配合 `expected_preview_state_token` 和 `expected_frame` 使用。
- `expected_preview_state_token`：可选，必须与 `niagara_preview_advance` 返回值一致，否则返回 `preview_state_token_mismatch`。
- `expected_frame` / `target_frame`：可选，按 `preview_tick_delta_seconds` 估算当前帧，不匹配时返回 `preview_frame_mismatch`。
- `require_paused`：可选，`current_preview` 默认 `true`；当前预览未暂停时返回 `preview_component_not_paused`。

返回字段包含 `file_path`、`width`、`height`、`bytes`、`target`、`capture_mode`、`legacy_backbuffer_capture=disabled`、`preview_prepare_requested`、`pre_preview_redraw_performed`、`capture_redraw_performed`。序列帧模式额外返回 `frame_count`、`frames[]`、`advance_semantics=continuous_from_zero`、`frame_sequence_capture_mode=continuous_from_zero_once`、`frame_capture_renderer`、`pixel_signature`、`pixel_signal`、`changed_pixel_count_from_previous` 和 `visual_duplicate_of_previous`；`preview_scene_capture` 还会返回 `render_dependency_wait`，包含 warmup capture 次数、等待前后 asset/shader 剩余任务数。多帧默认 `file_path` 指向总览图，并返回 `frame_sheet_created`、`frame_sheet_file_path`、`sequence_frame_image_path`、`individual_frame_files_created=false` 和 `frame_sheet{file_path,width,height,columns,rows,tile_width,tile_height,padding,label_scale}`。`columns` 与 `rows` 固定为最小正方形网格边长，等于 `ceil(sqrt(frame_count))`，不足格子为空。截图路径不会调用 `FSlateApplication::TakeScreenshot`，也不会强制 redraw 真实 Slate 窗口；`window_backbuffer_safe` 只作为诊断字段保留。

只读第 45 帧截图示例：

```json
{
  "command": "niagara_screenshot",
  "params": {
    "asset_path": "/Game/Niagara/NS_UAI_Rain_HighQuality",
    "target": "preview",
    "capture_mode": "current_preview",
    "expected_frame": 45,
    "expected_preview_state_token": "<niagara_preview_advance 返回的 preview_state_token>",
    "offscreen": true,
    "file_path": "Saved/UeAgentScreenshots/rain_frame_45.png"
  }
}
```

从 0 连续推进并截图 8 张 Niagara 预览帧：

```json
{
  "command": "niagara_screenshot",
  "params": {
    "asset_path": "/Game/Niagara/NS_UAI_HighQuality_Fire",
    "target": "preview",
    "start_frame_index": 0,
    "count": 8,
    "frame_interval": 12,
      "preview_tick_delta_seconds": 0.016667,
      "format": "png",
      "max_size": 1280
    }
  }
```

### `niagara_system_runtime_probe`

用于在 Niagara 编辑器预览组件上做非 PIE 的运行探针。该命令不会启动 game 窗口；它会按 `tick_count` 和 `tick_delta_seconds` 推进预览组件，并返回 System / Emitter 实例状态、粒子数、生成数和可选脚本运行统计。

关键参数：

- `asset_path`：必填，Niagara System 资产路径。
- `open_editor_if_needed`：可选，默认 `true`；为 `false` 时只复用已打开的 Niagara 编辑器。
- `reset_preview`：可选，默认 `true`；探针前重置预览组件。
- `tick_count`：可选，默认 `30`。
- `tick_delta_seconds`：可选，默认约 `1/60`。
- `advance_mode`：可选，`advance_simulation` 或普通 tick。
- `include_script_runtime_stats`：可选，返回 System / Emitter 脚本运行摘要。
- `include_snapshots`：可选，默认 `true`；为 `false` 时仍会采样并返回 `initial_stats`、`final_stats` 和 `summary`，但不展开每一帧 `snapshots[]`，避免报告过大。
- `sample_mode=current_preview`：只读当前已暂停的 preview 状态，不 reset、不 activate、不 tick、不修改时间。应配合 `expected_preview_state_token` 和 `expected_frame` 使用。
- `expected_preview_state_token`：可选，必须与 `niagara_preview_advance` 返回值一致，否则返回 `preview_state_token_mismatch`。
- `expected_frame` / `target_frame`：可选，按 `tick_delta_seconds` 估算当前帧，不匹配时返回 `preview_frame_mismatch`。
- `require_paused`：可选，`current_preview` 默认 `true`；当前预览未暂停时返回 `preview_component_not_paused`。

返回字段包含：

- `initial_stats` / `final_stats`：本次探针首尾统计。
- `summary.emitter_peaks[]`：每个 emitter 在本次探针采样期间的峰值统计，包括 `max_particle_count`、`max_total_spawned_particles`、`max_spawn_info_total_count` 及对应 snapshot label。
- `snapshots[]`：当 `include_snapshots=true` 时返回各阶段快照。

读取结果时不要只看最终快照。对 Collision Event、Death Event、短 lifetime 水花/火花这类瞬时粒子，最终帧可能已经归零，应优先看 `summary.emitter_peaks[]`。

注意：

- `open_editor_if_needed=true` 会按需打开 Niagara 编辑器；打开编辑器本身可能触发 UE 异步编译。需要稳定 runtime 数字时，推荐同一批次先 `niagara_open_editor`，再 `niagara_compile_system(force_compile=true, wait_for_complete=true)`，最后用 `niagara_system_runtime_probe(open_editor_if_needed=false)` 推进预览组件。
- 推荐新流程是 `niagara_preview_advance` 推进一次并暂停，然后用 `sample_mode=current_preview` 只读；不要让 screenshot 和 probe 分别重复推进同一帧。
- `reset_preview=true` 的 probe 会重建并推进预览仿真，适合验证从 0 开始的发射；它不等价于当前已暂停的编辑器画面。读取当前画面必须使用 `sample_mode=current_preview`。
- `reset_preview=false` 只表示不主动重置，但 legacy simulate 路径仍会配置和激活组件；不要再把 `reset_preview=false,tick_count=0` 当作严格只读采样。
- Ray Trace Collision / Event Handler 场景依赖预览世界和碰撞上下文。若重置后的 probe 与界面观察不一致，先对比 `component_source`、`component_world`、`reset_preview`、`advance_mode`，再判断资产是否有问题。

只读第 45 帧 probe 示例：

```json
{
  "command": "niagara_system_runtime_probe",
  "params": {
    "asset_path": "/Game/Niagara/NS_UAI_Rain_HighQuality",
    "sample_mode": "current_preview",
    "expected_frame": 45,
    "tick_delta_seconds": 0.016667,
    "expected_preview_state_token": "<niagara_preview_advance 返回的 preview_state_token>",
    "include_snapshots": true
  }
}
```

### `niagara_get_stack_issues`

用于读取 Niagara Stack 面板里的红色感叹号、黄色警告和信息提示。它读取 `UNiagaraStackEntry::FStackIssue`，并额外合并 Niagara `FNiagaraMessageStore` 中会显示到 Stack 的资产消息，例如 Emitter parent merge error。命令可覆盖整个 System scope，也可遍历 System 内每个 emitter handle；当 `asset_path` 指向 standalone `UNiagaraEmitter` 时，会读取该 Emitter 的 stack issue。

关键参数：

- `asset_path`：必填，Niagara System 或 standalone Emitter 资产路径。
- `severity_filter`：可选，默认 `warning_or_error`；支持 `all`、`error`、`warning`、`info`、`none`。
- `prefer_existing_view_model`：可选，默认 `true`；优先复用当前 Niagara 编辑器里的 live ViewModel。
- `open_editor_if_needed`：可选，默认 `false`；为 `true` 时会打开或复用 Niagara 编辑器以读取和 UI 一致的 live Stack。
- `include_system_scope`：可选，默认 `true`；读取 System scope stack。
- `include_emitters`：可选，默认 `true`；读取 System 内 emitter handle stack。
- `emitter_name` / `emitter_id` / `emitter_index`：可选，限制只读取某个 emitter。
- `compile_before_read`：可选，读取前触发 System 编译。

返回字段包含：

- `asset_path`、`asset_type`、`view_model_source`
- `scope_count`、`visited_stack_entry_count`
- `total_issue_count`、`returned_issue_count`
- `total_error_count`、`total_warning_count`、`total_info_count`
- `scopes[]`：每个 System / Emitter scope 的 `root_total_error_count`、`root_total_warning_count`、`root_total_info_count`、`message_store_source_count`、`message_store_candidate_message_count`、`message_store_added_issue_count`、`stack_issue_icon_kind`、`stack_issue_tooltip_summary`、`root_collected_issue_count_mismatch`
- Emitter scope 额外包含 `emitter_latest_compile_status`、`emitter_handle_error_text`、`emitter_handle_error_color`、`emitter_handle_error_visibility`，用于区分 Stack issue 图标和 emitter 编译/状态提示
- System scope 额外包含 `system_latest_compile_status`
- `issues[]`：每条 issue 的 `severity`、`short_description`、`long_description`、`entry_path`、`entry_class`、`scope_type`、`scope_name`、`module_name`、`module_node_guid`、`module_script_asset_path`、`stage_key`、`fixes[]`；MessageStore 来源的 issue 会额外包含 `issue_origin=message_store`、`message_key`、`message_topic`、`message_source_path`

注意：

- `niagara_get_compile_log` 读取的是 Niagara 编译事件；Stack 面板红色感叹号可能来自 live Stack ViewModel 的依赖校验，不一定出现在 compile log。
- `stack_issue_icon_kind` 按 UE `SNiagaraStackIssueIcon` 的优先级输出：有 error 时为 `error`，否则有 warning 时为 `warning`，否则有 info 时为 `info`，否则为 `none`。`stack_issue_tooltip_summary` 对应该图标悬停摘要，例如 `1 error`、`2 infos`。
- `root_total_*` 是 Stack root 当前聚合计数；`total_*` 会再合并 MessageStore issue。若 `root_collected_issue_count_mismatch=true` 且 `message_store_added_issue_count>0`，通常表示 UI tooltip 中包含了资产消息，例如 `未能从父发射器合并变更`。
- 要尽量匹配 UI 里鼠标悬停看到的红色感叹号文本，建议使用 `prefer_existing_view_model=true` 且 `open_editor_if_needed=true`。
- 未打开编辑器时命令会退回 data-processing ViewModel；这能读取部分 issue，但可能漏掉 UI-only / live Stack 状态。

示例：

```json
{
  "request_id": "ns-stack-issues",
  "command": "niagara_get_stack_issues",
  "params": {
    "asset_path": "/Game/Niagara/NS_MissileTargetExplosion",
    "severity_filter": "all",
    "prefer_existing_view_model": true,
    "open_editor_if_needed": true,
    "include_system_scope": true,
    "include_emitters": true
  }
}
```

### `niagara_apply_stack_issue_fix`

用于匹配 `niagara_get_stack_issues` 返回的 issue，并执行该 issue 中的 `fixes[]`。常用在 Niagara UI 有红色感叹号且 tooltip 指向依赖、父 emitter merge 或 Stack 校验问题时。

关键参数：

- `asset_path`：必填，Niagara System 资产路径。
- issue selector：可用 `issue_unique_identifier`、`module_node_guid`、`entry_path`、`scope_type`、`scope_name`、`emitter_name`、`emitter_id`、`emitter_index` 等字段缩小匹配范围。
- `fix_index` / `fix_unique_identifier`：可选，指定使用哪一个 fix。
- `apply_first_match`：可选，默认 `false`；多匹配时是否直接使用第一条。
- `compile_after_apply`、`force_compile`、`wait_for_complete`、`save_after_apply`：可选。

执行 fix 后会调用 System refresh：同步 overview、重算 emitter execution order、失效 cached traversal data，并通知 Niagara ViewModel。

## System 属性与编译

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_system_get_property` | 读取 System 属性 | `asset_path`、`property_name` | 查询 Loop、Scalability 配置 |
| `niagara_refresh_system` | 刷新 System 结构、执行顺序和缓存 | `asset_path`、`broadcast_post_edit_change`、`compile_after_refresh`、`save_after_refresh` | UAI 写入后避免必须手动新增/删除 emitter 才生效 |
| `niagara_compile_system` | 触发编译 | `asset_path`、`force_compile`、`wait_for_complete`、`mark_dirty_after_compile` | 修改后立即校验 |
| `niagara_get_compile_log` | 读取编译日志与事件 | `asset_path`、`severity_filter`、`include_events`、`max_events_per_script` | 定位 Unknown/编译失败原因 |

System 属性写入应通过 Niagara folder JSON 主流程表达；apply 结果会返回 `requested_value_text`、`applied_value_text`、`property_value_read_back`、`property_import_status`、`property_import_verified`、`property_import_error`、`value_text_exact_match`、`value_text_changed_after_import`、`cpp_type` 等观测字段，用于发现属性不存在、`ImportText` 解析失败或写后读回被 UE 规范化/回退。

### `niagara_refresh_system`

用于修复 Niagara System 在结构化写入、Stack fix、Emitter parent 清理、Stage/Module 输入改写之后的编辑器缓存和运行图状态。该命令会同步 `UNiagaraSystemEditorData` overview graph，重新计算 emitter execution order，失效 system cached traversal data，并通过 System post-edit 通知刷新已打开的 Niagara ViewModel；未打开编辑器时会创建 data-processing ViewModel 触发同等数据刷新。

关键参数：

- `asset_path`：必填，Niagara System 资产路径。
- `broadcast_post_edit_change`：可选，默认 `true`；通知已打开的 Niagara 编辑器刷新 ViewModel / preview。
- `mark_dirty`：可选，默认 `true`；刷新后标记资产 dirty。
- `compile_after_refresh`：可选，默认 `true`；刷新后立即编译。
- `force_compile`：可选，默认 `true`。
- `wait_for_complete`：可选，默认 `true`。
- `save_after_refresh`：可选，默认 `false`。

返回字段包含 `system_refresh`，其中 `synchronized_overview_graph`、`rebuilt_emitter_nodes`、`computed_execution_order`、`invalidated_cached_data`、`broadcast_post_edit_change`、`created_data_processing_view_model` 可用于确认刷新路径是否执行。`rebuilt_emitter_nodes=true` 表示命令已把 System graph 中的 emitter 节点链同步重建到当前 `FNiagaraEmitterHandle` 列表，避免 System 编译数据缺失 emitter spawn/update 信息。该实现使用公开图节点 API 和反射创建 `NiagaraNodeEmitter`，不依赖未导出的 `FNiagaraStackGraphUtilities::RebuildEmitterNodes` 符号。

注意：

- `niagara_compile_system` 对 `UNiagaraSystem` 默认 `refresh_before_compile=true`，因此普通编译也会先走上述刷新路径。编译校验默认不主动标记资产 dirty；需要保存编译结果时传 `mark_dirty_after_compile=true` 或 `save_after_compile=true`。
- `niagara_get_compile_log` 的 `compile_before_read=true` 也可触发读前刷新，但该读路径不会主动标记 System dirty；需要写入语义时使用 `niagara_refresh_system` 或 `niagara_compile_system`。
- 对 `mark_dirty=false` 的刷新、默认校验编译、读前编译日志，若 UE 内部刷新/编译过程临时把原本 clean 的包置 dirty，命令会恢复原 dirty 状态并返回 `restored_dirty_state=true`。
- 若 UI 中出现“新增一个空 emitter 后 system 才恢复”的现象，优先对目标 System 执行 `niagara_refresh_system`，再读 compile log、Stack issue 和 runtime probe。

## System User 参数 CRUD

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_user_parameter_list` | 列出 User 参数 | `asset_path`、`include_values` | 检查参数是否存在 |
| `niagara_user_parameter_get` | 读取单个 User 参数 | `asset_path`、`parameter_name` | 回读验证 |

## System 内 Emitter 管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_system_list_emitters` | 列出 System 中发射器 | `asset_path` | 获取 emitter_id / index |

> 结构化写入涉及 emitter handle 变动时，apply 默认会在改动前关闭该 System 已打开的 Niagara 编辑器页，返回 `closed_open_editor_before_structural_edit` 和 `closed_editor_count`。这是为了避免 live Niagara Overview/Stack 在 emitter handle 变动时继续刷新旧选择对象导致 UE 崩溃。确实需要保留编辑器页时可传 `close_open_editor_before_structural_edit=false`，但自动化测试不建议这样做。

> System 结构化 apply 默认会执行完整 refresh 和强制编译，并在返回中包含 `system_refresh`。成功结果应重点检查 `system_refresh.rebuilt_emitter_nodes=true`、`compiled_emitter_data_count` 与 `emitter_ready_to_run`；如果只看到 System handle 但 runtime probe 无粒子，优先检查这几个字段，而不是通过手动新增空 emitter 触发编辑器刷新。

## 组合流程建议

1. `niagara_create_system` 创建最小可运行骨架。
2. `niagara_export_folder` 导出真实模板。
3. 写入基础 emitter/module/user parameter JSON。
4. `niagara_apply_folder` 应用并读取返回的 `warnings`、`stack_issues`、`stack_error_count`。
5. 再次 `niagara_export_folder`，基于 UE 补全后的 module 属性继续修改。
6. 再次 `niagara_apply_folder`。
7. `niagara_get_compile_log` 和 `niagara_system_runtime_probe` 做最终验证。

## 最小请求示例

```json
{
  "request_id": "ns-001",
  "command": "niagara_get_compile_log",
  "params": {
    "asset_path": "/Game/AutoTests/Niagara/NS_Test",
    "compile_before_read": true,
    "wait_for_complete": true,
    "severity_filter": "warning_or_error"
  }
}
```

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/07_Niagara_System.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。

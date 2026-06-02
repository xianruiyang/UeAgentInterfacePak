# Project Settings / Config 指令

本分册覆盖 UE Project Settings 的实时反射导出、结构化 JSON 回写、只读校验、差异预览，以及受限 `.ini` section fallback。它不是静态字段表：命令每次运行都从当前 Editor 的 `ISettingsModule`、已启用插件和 Settings UObject 重新生成 index、schema 和 values。

## 边界

- Project Settings 页面优先走 `project_settings_*`。只有没有注册 Settings UObject、或明确需要编辑裸 `.ini` section 时才用 `config_*` fallback。
- `project_settings_*` 不手写固定字段，也不假设某个 UE 版本或插件一定存在某页；index/page JSON 会随引擎版本和插件启用状态动态变化。
- 自定义 Slate Settings 页面如果没有 `GetSettingsObject()`，会返回 `support_level=unsupported_custom_settings_ui` / `unsupported_custom_settings_ui`，不会伪造字段。
- 写入前会重新定位当前 section 和当前 `FProperty`，未知字段、只读字段、类型不匹配会进入 `field_results[]` 并使 apply 失败。
- `project_settings_apply_page` 与 `config_apply_section` 默认 `dry_run=true`；真实写入必须显式传 `dry_run=false`。
- `project_settings_apply_page` 真实写入采用两阶段流程：先完整预检所有字段并准备待写值；只有无字段错误且备份成功后才写入 Settings UObject，避免同一 patch 中前半部分成功、后半部分失败造成部分写入。
- `config_apply_section` fallback 同样先预检全部 set/remove 操作；remove key 为空或其他配置操作错误时整体失败，不写入任何 config key；真实写入前先完成 backup。
- `dry_run`、`backup`、`read_back`、`schema_mismatch_policy` 可放在命令顶层，也可放在输入 JSON 或 `json_file` 的 `options{}` 中；命令顶层优先级更高。
- 传入 `base_field_schema_hash` 或整页 `settings.json` 时会和当前反射得到的 `field_schema_hash` 对比；默认 `schema_mismatch_policy=fail`，可改为 `dry_run_only` 或 `apply_matching_fields`。
- `config_*` 只允许项目 `Config/DefaultGame.ini`、`DefaultEngine.ini`、`DefaultInput.ini`、`DefaultEditor.ini`、`DefaultEditorPerProjectUserSettings.ini`，拒绝路径穿越和项目外文件。

## 动态文件夹结构

默认输出根目录：

```text
Saved/UeAgentInterface/ProjectSettings/
```

结构：

```text
index.json
manifest.json
<container_slug>/<category_slug>/<section_slug>/settings.json
```

`manifest.json` 以 `section_id` 映射实际文件路径。`section_id` 形式为：

```text
Container.Category.Section
```

例如 `Project.Project.General`。

## 协议兼容字段

所有 Project Settings / Config 返回都会保留早期字段，同时补齐设计文档中的标准字段：

- `profile` 保留为 UAI 内部 profile；`schema` 是对外 JSON 协议名。
- `generated_at_utc` 保留；`generated_at` 是协议兼容别名。
- `output_directory` / `output_dir` 仍可用；`output_path` 可直接指定 `index.json` 或 page `settings.json`。
- page 仍保留顶层 `section` 字符串；结构化 section 描述放在 `section_info{}`，避免破坏既有调用。
- `backup_file` 保留；`backup_path` 是设计文档兼容别名。

## Project Settings

| 指令 | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `project_settings_export_index` | 反射当前所有 Settings container/category/section 并导出目录索引 | `container`、`include_plugin_sections`、`include_developer_sections`、`include_readonly_sections`、`include_unsupported_sections`、`include_field_counts`、`output_directory`、`output_path`、`write_files` | `schema`、`sections[]`、`manifest.entries[]`、`summary`、`filters{}`、`section_count`、`settings_registry_hash`、`plugin_fingerprint`、`plugin_fingerprint_hash`、`index_file`、`manifest_file` |
| `project_settings_export_page` | 导出某个 Settings 页的字段 schema 与当前值 | `section_id` 或 `container/category/section`、`output_directory`、`output_file`/`output_path`、`write_file`、`include_non_editable`/`include_hidden_properties`、`include_raw_config`、`include_defaults`、`include_metadata` | `schema`、`section_info{}`、`fields{}`、`values{}`、`field_schema_hash`、`page_value_hash`、`settings_object`、`capabilities`、`raw_config`、`raw_config_file` |
| `project_settings_validate_page` | 只读校验 patch/json_file 能否按当前反射 schema 写入 | `section_id`、`values{}` 或 `patch{}` 或 `fields{}`/`fields[]` 或 `json_file`、`schema_mismatch_policy` | `valid`、`error_count`、`field_results[]` |
| `project_settings_diff_page` | 只读生成字段差异，不落盘 | 同 validate | `changed`、`field_diffs[]`、`field_results[]` |
| `project_settings_apply_page` | 回写 Settings UObject，保存配置并读回 | `section_id`、`values{}`/`patch{}`/`fields{}`/`fields[]`/`json_file`、`dry_run`、`backup`、`read_back`、`schema_mismatch_policy`、`allow_unknown_fields`、`preserve_unknown_fields`、`fail_on_unsupported_field`、`fail_on_requires_restart`、`allow_high_risk` 或 `options{}` | `schema`、`success`、`applied_field_count`、`changes[]`、`field_results[]`、`errors[]`、`warnings[]`、`backup_file`/`backup_path`、`read_back`、变更影响标记 |

`project_settings_export_page` 的字段项包含：

- `name`
- `display_name`
- `tooltip`
- `category`
- `category_path[]`
- `description`
- `cpp_type`
- `json_type`
- `property_class`
- `metadata`
- `editable`
- `visible`
- `config_key`
- `config_source`
- `property_flags[]`
- `is_config`
- `default_value`
- `value`
- `value_text`
- `field_schema_hash`
- `apply_support`
- `applied_immediately`
- `requires_config_reload`
- `requires_editor_reopen`
- `requires_restart`
- `requires_rebuild`
- `requires_asset_rescan`
- `requires_navigation_rebuild`
- `requires_shader_recompile`
- `requires_plugin_enabled`
- `enum_options[]`，如果字段是 enum/byte enum

`value` 是结构化 JSON；`value_text` 是 UE `ImportText` 兼容文本，作为复杂类型兜底和诊断证据保留。

`project_settings_export_index` 的过滤参数默认都为 `true`。`include_plugin_sections=false` 会排除插件来源或 `Plugins` 分类页面；`include_developer_sections=false` 会排除 Developer 相关页面；`include_readonly_sections=false` 会排除当前 Settings section 不可编辑的页面；`include_field_counts=false` 会从 `sections[]` 中省略 `field_count` / `writable_field_count`，但仍保留 `field_schema_hash` 和 `page_value_hash` 供 schema 比较使用。实际使用的过滤条件会回显在 `filters{}`。

`project_settings_export_page` 默认返回 `default_value` 和 `metadata{}`；传 `include_defaults=false` / `include_metadata=false` 时只省略对应扩展字段，不影响 `value`、`field_schema_hash`、`config_key` 等回写和校验所需字段。

`sections[]` 和 page JSON 会同时返回动态来源信息：slug/folder path、`settings_class` / `settings_object_path`、`config_file` / `config_section`、`source_module`、`source_plugin`、`requires_plugin`、字段数量、可写字段数量、`field_schema_hash`、`page_value_hash` 和重启/配置重载提示。插件 settings 页的 `requires_plugin` 来自当前启用插件模块匹配；没有 Settings UObject 的自定义 Slate 页仍以 `unsupported_custom_settings_ui` 返回，不伪造字段。

`project_settings_apply_page` / validate / diff 的 `field_results[]` 会给每个字段返回同一组变更影响标记。类型不匹配统一返回 `error=invalid_json_value_type`，原始导入细节保存在 `error_detail`。

写入结果字段同时包含：

- `old_value`、`requested_value`、`applied_value`、`read_back_value`
- `status=validated|pending_apply|applied|read_back_mismatch|skipped_due_to_errors|skipped_unknown_field|skipped_unsupported_field|requires_restart_blocked|high_risk_blocked`
- `config_file`、`config_key`
- `changes[]` 只收集实际发生变化或 diff 关心的字段；`field_results[]` 保留所有输入字段结果。

schema mismatch 策略：

- `fail`：默认。输入的 `base_field_schema_hash` / `field_schema_hash` 与当前页面不一致时返回 `field_schema_changed`，不写入。
- `dry_run_only`：即使命令传了 `dry_run=false`，也强制只校验/只 diff，不写入。
- `apply_matching_fields`：只尝试应用仍存在且字段 schema 未变化的字段；必须传入整页导出的 `fields{}` 或带字段级 `field_schema_hash` 的 `fields{}` patch。只有 `values{}` 而没有字段 schema 时返回 `field_schema_matching_requires_exported_fields`；字段级 schema 变化会返回 `skipped_schema_mismatch`。

常见错误码：

| 错误码 | 含义 |
| --- | --- |
| `settings_section_not_found` | 当前 Settings registry 中找不到目标 page |
| `settings_object_missing` | section 声明有默认 settings object，但运行时未取到可反射对象 |
| `unsupported_custom_settings_ui` | section 是无 UObject 的自定义 Settings UI，不能通用反射回写 |
| `field_not_found` | patch 字段不存在 |
| `field_not_editable` | 字段不可编辑，且未允许跳过 unsupported 字段 |
| `unsupported_property_type` | 字段值无法用当前 JSON/import-text 路径表达 |
| `invalid_json_value_type` | JSON 值类型与字段导入要求不匹配 |
| `field_schema_changed` | 输入 schema hash 与当前实时反射 schema 不一致 |
| `field_schema_matching_requires_exported_fields` | `apply_matching_fields` 缺少字段级 schema |
| `requires_plugin_not_enabled` | 输入声明需要的插件当前未启用 |
| `requires_restart_blocked` | 字段需要重启且请求设置了 `fail_on_requires_restart=true` |
| `high_risk_blocked` | 高风险设置真实写入未显式传 `allow_high_risk=true` |
| `config_apply_failed` | config fallback set/remove 预检失败，未写入任何 key |
| `invalid_config_key` | config fallback 的 set key 或 remove key 为空/无效 |
| `config_cache_unavailable` | UE config cache 不可用 |
| `config_backup_failed` | 写入前备份配置文件失败 |
| `config_save_failed` | Settings section/config 保存失败 |
| `read_back_mismatch` | 写入后读回值与预期不一致 |

写入示例：

```json
{
  "section_id": "Project.Project.General",
  "dry_run": false,
  "backup": true,
  "read_back": true,
  "values": {
    "ProjectVersion": "1.2.3",
    "CompanyName": "Example Studio"
  }
}
```

也可以直接编辑导出的 `settings.json`，再传；`json_file` 内有 `section_id` 时可不在命令顶层重复传：

```json
{
  "json_file": "D:/.../settings.json"
}
```

整页/文件输入兼容两种字段形态：当前导出默认使用 `fields{ "FieldName": { ... } }`，也接受 `fields[]` 数组项中的 `name/value/field_schema_hash`。

## Config Fallback

| 指令 | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `config_export_section` | 导出受限项目 `.ini` 的 section | `config_file`、`section`、`output_file`/`output_path` | `schema`、`source=config_file_fallback`、`source_path`、`entries[]`、`values{}`、`entry_count`、`section_value_hash` |
| `config_apply_section` | 对受限 `.ini` section 执行 set/remove 并读回 | `config_file`、`section`、`set{}`、`remove[]`、`dry_run`、`backup`、`read_back` 或 `options{}` | `schema`、`success`、`source=config_file_fallback`、`source_path`、`results[]`、`changes[]`、`errors[]`、`warnings[]`、`operation_count`、`backup_file`/`backup_path`、`read_back` |

数组写入使用 JSON array：

```json
{
  "config_file": "DefaultGame.ini",
  "section": "UeAgentInterface.ProjectSettingsSmoke",
  "dry_run": false,
  "set": {
    "SmokeKey": "value",
    "SmokeArray": ["A", "B"]
  },
  "read_back": true
}
```

## 测试覆盖

- 自动化测试：`GptProjectTest.UeAgentInterface.Smoke.ProjectSettingsJsonWorkflow`。
- 覆盖：
  - index 导出与 `manifest.json`
  - 通过实时反射定位 `GeneralProjectSettings`
  - page 导出、`field_schema_hash`、`page_value_hash`
  - `dry_run` 不落盘
  - 真实 `ProjectName` / `ProjectVersion` / `CompanyName` apply、读回、恢复
  - `fields[]` + `json_file` 输入、`options{}`、三字段写入
  - `apply_matching_fields` 带字段级 schema 时三字段写入；仅 `values{}` 时拒绝写入
  - `raw_config`、变更影响标记、`invalid_json_value_type`
  - `schema` / `generated_at` / `project_name` / `plugin_fingerprint_hash` 协议字段
  - `output_path`、index 过滤参数、`include_field_counts=false`、`include_raw_config=false`、`include_hidden_properties`、`include_defaults=false`、`include_metadata=false`
  - `section_info{}`、`manifest.entries[]`、`raw_config_file`
  - 字段级 `json_type`、`default_value`、`config_key`、`config_source`、`property_flags[]`
  - apply `success`、`changes[]`、`errors[]`、`warnings[]`、`backup_path`、`requested_value` / `applied_value` / `read_back_value`
  - `allow_unknown_fields` 和 `fail_on_unsupported_field=false`
  - invalid field 的 validate/apply 失败诊断
  - mixed valid + invalid apply 不产生部分写入
  - `config_apply_section / config_export_section` set、array、remove、`source_path`、`backup_path` 和读回
  - config fallback mixed valid + invalid apply 不产生部分写入

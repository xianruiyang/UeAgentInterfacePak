# Localization / Packaging / Platform Profiles

本分册覆盖 UE 项目生产管线层面的本地化、String Table、项目打包、目标平台、Device Profile、Scalability 和平台配置语义命令。

边界：

- 普通 Project Settings 字段仍使用 `project_settings_export_page / project_settings_apply_page`。
- 通用 `.ini` section 裸写仍使用受限 `config_*` fallback；本分册只做平台、DeviceProfile、Scalability 和 Localization target 的语义读写。
- `packaging_*` 指 UE 项目 UAT/cook/stage/package/archive，不做 UAI 插件/CLI/Pak 仓库发布，也不提交 Git。
- 真实长任务默认不执行；需要显式 `execute=true` 且传入对应许可字段，例如 `allow_uat=true` 或 `allow_commandlet=true`。

## Localization

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `localization_query_targets` | 查询 Localization target、culture、manifest/archive/locres/PO 文件 | `include_stats`, `include_files` | `targets[]`, `target_count`, `content_root`, `config_root` |
| `localization_export_json` | 导出本地化拓扑 JSON | `target`, `output_file`, `include_entries`, `include_word_count` | `schema=uai.localization.v1`, `targets[]`, `string_tables[]` |
| `localization_validate_json` | 校验 target、culture、路径和 StringTable 引用 JSON | `json` 或 `json_file`, `strict` | `valid`, `issues[]`, `error_count` |
| `localization_diff_json` | 比较目标 JSON 与当前发现状态 | `json` 或 `json_file` | `changed`, `diffs[]`, `diff_count` |
| `localization_apply_json` | 创建/更新 target 目录、最小 target config、StringTable 引用 | `json` 或 `json_file`, `dry_run`, `backup`, `save_policy` | `changed`, `results[]`, `backup_paths[]` |
| `localization_gather_text` | 生成或执行 GatherText commandlet 计划 | `target`, `execute`, `timeout_seconds`, `allow_commandlet` | `task_id`, `status`, `commandlet_plan`, `log_file`, `report_file` |
| `localization_export_po` | 扫描并导出 PO 文件 | `target`, `cultures[]`, `output_dir`, `execute` | `po_files[]`, `entry_count` |
| `localization_import_po` | 导入 PO 文件到 target/culture 目录 | `target`, `culture`, `po_file`, `dry_run`, `backup` | `imported_count`, `translated_count`, `backup_paths[]` |
| `localization_compile_text` | 生成或执行文本资源编译计划 | `target`, `cultures[]`, `execute`, `timeout_seconds`, `allow_commandlet` | `task_id`, `status`, `locres_files[]`, `compiled_count` |
| `localization_report` | 汇总 PO 覆盖和缺失信息 | `target`, `cultures[]`, `include_assets` | `coverage_by_culture[]`, `missing[]`, `stale[]` |
| `localization_preview_culture` | 当前编辑器会话切换 culture 并可立即恢复 | `culture`, `scope`, `restore_after` | `previous_culture`, `current_culture`, `restored` |

补充约束：

- `localization_apply_json` 只处理 Localization target 拓扑和 String Table 引用；如果输入只包含普通 Project Settings 字段，会返回 `use_project_settings_required`，应改用 `project_settings_apply_page`。
- `localization_import_po` 会先解析 PO，找不到 `msgid` 条目时返回 `po_parse_failed`，不会复制不可解析文件。
- `localization_export_po execute=true` 会按 target 下的 culture 子目录保留输出结构，例如 `en/Game.po` 和 `zh-Hans/Game.po` 不会互相覆盖。

## String Table

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `string_table_export_json` | 导出 `UStringTable` namespace、entry 和 metadata | `asset_path`, `output_file` | `namespace`, `entries[]`, `entry_count` |
| `string_table_validate_json` | 校验 key/source/metadata 和重复 key | `json` 或 `json_file` | `valid`, `issues[]`, `error_count` |
| `string_table_diff_json` | 比较目标 JSON 与当前资产 entry | `asset_path`, `json` 或 `json_file` | `changed`, `added[]`, `removed[]`, `changed_entries[]` |
| `string_table_apply_json` | 创建或更新 `UStringTable` entry/metadata | `asset_path`, `json` 或 `json_file`, `dry_run`, `backup`, `save_after_apply` | `created`, `changed_count`, `readback` |

## Packaging

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `packaging_query_environment` | 查询 UAT、UnrealEditor-Cmd、UnrealPak、target platform 和 SDK 状态 | `include_sdks`, `include_tools` | `tools[]`, `target_platforms[]` |
| `packaging_export_profile_json` | 导出 transient BuildCookRun profile | `platform`, `configuration`, `include_project_settings`, `output_file` | `schema=uai.packaging.v1`, `target`, `pipeline`, `settings_refs[]` |
| `packaging_validate_profile_json` | 校验平台、配置、map、UAT 和 archive 目录 | `json` 或 `json_file` | `valid`, `issues[]`, `estimated_actions[]` |
| `packaging_diff_profile_json` | 比较 transient profile 与当前默认 profile | `json` 或 `json_file` | `setting_diffs[]`, `transient_overrides[]` |
| `packaging_plan_build` | 生成 UAT BuildCookRun 命令计划 | `json` 或 `json_file`, `platform`, `configuration`, `cook`, `stage`, `package`, `archive` | `command_line`, `uat_args[]`, `artifacts_expected[]` |
| `packaging_run_build` | 计划或执行 UAT 打包任务 | `json` 或 `json_file`, `execute`, `timeout_seconds`, `allow_uat` | `task_id`, `status`, `log_file`, `report_file` |
| `packaging_task_status` | 查询 UAI 任务记录或当前进程状态 | `task_id` | `running`, `exit_code`, `phase`, `last_log_lines[]` |
| `packaging_cancel_task` | 取消 planned/running 任务 | `task_id`, `kill_process_tree` | `cancelled`, `processes[]` |
| `packaging_parse_log` | 解析 UAT/cook log 的 error/warning | `log_file`, `classify_errors` | `errors[]`, `warnings[]`, `phase_summary` |
| `packaging_report_artifacts` | 扫描 archive 目录产物 | `archive_dir`, `platform`, `include_hashes` | `artifacts[]`, `total_size`, `missing_expected[]` |
| `packaging_clean_artifacts` | 清理 Project/Saved 下 UAI 托管打包输出 | `archive_dir`, `dry_run`, `max_delete_bytes` | `deleted[]`, `freed_bytes` |

`packaging_run_build` 在注册任务和启动 UAT 前会完整复用 `packaging_validate_profile_json` 的 profile 校验；存在 `map_not_found`、`archive_dir_unsafe`、`uat_not_found` 等错误时直接返回 `packaging_validate_failed`，不会生成 `task_id` 或启动进程。`packaging_plan_build` 可用于查看同一 profile 的命令计划和 `issues[]`。

## Platform Profiles

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `target_platform_query` | 查询当前引擎 target platform 与 SDK 状态 | `include_sdk`, `include_texture_formats` | `target_platforms[]`, `sdk_status[]` |
| `platform_config_export_json` | 导出平台 config 合并摘要 | `platform`, `sections[]`, `include_sources`, `output_file` | `merged_values{}`, `source_files[]` |
| `platform_config_validate_json` | 校验平台 config patch 白名单与 section 结构 | `json` 或 `json_file` | `valid`, `issues[]` |
| `platform_config_apply_json` | 写入受控平台 config patch | `json` 或 `json_file`, `dry_run`, `backup` | `changes[]`, `backup_paths[]` |
| `device_profile_query` | 查询 DeviceProfile、继承链和 CVar | `profile`, `include_inherited` | `profiles[]`, `inheritance_chain[]`, `cvars` |
| `device_profile_export_json` | 导出 DeviceProfile JSON | `profile`, `output_file`, `include_inherited` | `schema=uai.device_profile.v1`, `profiles[]` |
| `device_profile_validate_json` | 校验 DeviceProfile schema、CVar、base profile 和循环 | `json` 或 `json_file` | `valid`, `issues[]` |
| `device_profile_diff_json` | 比较目标 DeviceProfile 与当前配置 | `json` 或 `json_file` | `added_cvars[]`, `removed_cvars[]`, `changed_cvars[]` |
| `device_profile_apply_json` | 创建或更新项目 `DefaultDeviceProfiles.ini` | `json` 或 `json_file`, `dry_run`, `backup`, `read_back` | `changed`, `changes[]`, `readback` |
| `device_profile_resolve_cvars` | 解析 profile 继承后的最终 CVar | `profile`, `keys[]`, `include_sources` | `resolved_cvars[]`, `conflicts[]`, `inheritance_chain[]` |
| `scalability_export_json` | 导出 Scalability group 配置 | `platform`, `output_file` | `groups[]`, `quality_levels[]`, `group_count` |
| `scalability_validate_json` | 校验 Scalability JSON | `json` 或 `json_file` | `valid`, `issues[]` |
| `scalability_apply_json` | 写入项目 `DefaultScalability.ini` | `json` 或 `json_file`, `dry_run`, `backup` | `changes[]`, `readback` |
| `platform_profile_validate_packaging` | 联合校验 packaging profile、platform 和 device profile | `packaging_json`, `platform`, `device_profile` | `valid`, `issues[]`, `warnings[]` |

平台 config 写入只接受受控白名单文件：

- `DefaultEngine.ini`、`DefaultGame.ini`、`DefaultDeviceProfiles.ini`、`DefaultScalability.ini`
- `<Platform>/<Platform>Engine.ini`、`<Platform>/<Platform>Game.ini`、`<Platform>/<Platform>DeviceProfiles.ini`
- `Config/<Platform>/<Platform>Engine.ini`、`Config/<Platform>/<Platform>Game.ini`、`Config/<Platform>/<Platform>DeviceProfiles.ini`

绝对路径、盘符、`..`、`.` 和其他路径穿越写法会返回 `platform_config_file_not_allowed`。`scalability_export_json` 返回 `groups[]` 的同时会返回从 section 名称解析出的 `quality_levels[]`。

## 长任务记录

长任务记录写入：

```text
Saved/UeAgentInterface/Tasks/<task_id>/
```

每个任务至少包含：

- `command.txt`
- `stdout.log`
- `report.json`

真实执行时命令会以隐藏进程启动，并用 `timeout_seconds` 限制；超时会标记 `status=timed_out` 并保留日志。

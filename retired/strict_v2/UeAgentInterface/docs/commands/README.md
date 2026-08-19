# UeAgentInterface 指令文档索引

本目录采用“类别文件夹 + 单命令 Markdown”结构。命令正文以各类别下的 `<command>.md` 为真源；根目录不再承载大分册正文。

## 查询入口

- Python search: `uai_core.command_docs.search_commands("viewport screenshot", project_root=ProjectRoot, limit=3)` 默认返回 TSV 字符串；需要结构化列表时传 `output_format="json"`。
- Python show: `uai_core.command_docs.show_command("level_export_folder", project_root=ProjectRoot, profile="authoring", output_format="json")`；JSON 正文在 `sections`，不是 `content`。
- Python pack: `uai_core.command_docs.pack_commands(["node_catalog_search", "level_export_folder", "level_apply_folder"], project_root=ProjectRoot, profile="authoring")` 返回自足命令包。
- CLI search: `python <UaiCmdRoot>/run_uai_cli.py command search "viewport screenshot" --project-root <ProjectRoot> --limit 3 --json`
- CLI show: `python <UaiCmdRoot>/run_uai_cli.py command show level_export_folder --project-root <ProjectRoot> --profile authoring --format json --json`
- CLI pack: `python <UaiCmdRoot>/run_uai_cli.py command pack node_catalog_search umg_export_folder umg_apply_folder --project-root <ProjectRoot> --profile authoring --output tmp/umg_pack.md`
- 路径规则：示例只使用 `<UaiCmdRoot>`、`<ProjectRoot>` 或显式 `docs_root`；不要依赖本机固定绝对路径，也不要搜索源码或旧模板推断 JSON 字段。
- Authoring 规则：`profile=authoring` 对应 `llm_authoring` folder HJSON；先按该领域 folder contract 读取必需 identity/entry 文件，再按需打开具体 authoring unit，不假定所有领域都存在 `manifest.hjson` 或 references。Catalog seed 从 `node_catalog_search.items_tsv` 读取，公开主路径优先使用契约声明的 identity 字段。
- Graph 规则：图逻辑写在 `graphs/items/<graph_id>/graph.hjson`，视觉布局写在 `graphs/items/<graph_id>/layout.hjson`；修改逻辑不需要读取 layout。
- Coverage 规则：如果命令包中某类 `validate` / `diff` 为 `missing`，不要写成 full coverage；使用 export/readback、command response、consistency gate 或结构化比较补证据。

## Active Categories

- [ai_behavior_blackboard_statetree_eqs_navigation_smartobject](./ai_behavior_blackboard_statetree_eqs_navigation_smartobject/README.md)
- [anim_blueprint](./anim_blueprint/README.md)
- [animation_assets_skeleton](./animation_assets_skeleton/README.md)
- [audio](./audio/README.md)
- [blueprint](./blueprint/README.md)
- [control_rig_folder_format](./control_rig_folder_format/README.md)
- [core_level](./core_level/README.md)
- [data_driven_data_asset_data_table](./data_driven_data_asset_data_table/README.md)
- [deformer_mldeformer_geometry_cache](./deformer_mldeformer_geometry_cache/README.md)
- [editor_viewport](./editor_viewport/README.md)
- [ikrig_ikretargeter](./ikrig_ikretargeter/README.md)
- [level_content](./level_content/README.md)
- [level_topology_streaming_world_partition_data_layer_hlod](./level_topology_streaming_world_partition_data_layer_hlod/README.md)
- [localization_packaging_platform_profiles](./localization_packaging_platform_profiles/README.md)
- [material](./material/README.md)
- [modeling](./modeling/README.md)
- [montage](./montage/README.md)
- [niagara_emitter](./niagara_emitter/README.md)
- [niagara_folder_format](./niagara_folder_format/README.md)
- [niagara_stage_graph](./niagara_stage_graph/README.md)
- [niagara_system](./niagara_system/README.md)
- [node_graph](./node_graph/README.md)
- [pcg](./pcg/README.md)
- [physics_baseline](./physics_baseline/README.md)
- [probe](./probe/README.md)
- [project_settings_config](./project_settings_config/README.md)
- [sequence](./sequence/README.md)
- [skeletal_mesh_folder_format](./skeletal_mesh_folder_format/README.md)
- [static_mesh_enhanced_input](./static_mesh_enhanced_input/README.md)
- [texture_render_target_media](./texture_render_target_media/README.md)
- [umg](./umg/README.md)

## Deprecated

- 废弃命令已拆分到 [`deprecatedCommand/`](./deprecatedCommand/README.md)。默认查询隐藏 deprecated，迁移/诊断/修复时显式开启。
- 旧大分册已归档到 `_legacy_big_docs/`，只作历史追溯，不作为 LLM 默认读取入口。

# Deprecated UAI Command Docs

本目录同样采用“类别文件夹 + 单命令 Markdown”结构。deprecated 命令只用于兼容、迁移、诊断、修复、bootstrap、schema-boundary 或 smoke，不作为新 authoring 主流程，也不进入默认 command pack 示例。

使用 deprecated 命令前必须确认当前替代命令、folder workflow 或 JSON authoring 不能覆盖该操作，并记录 `deprecated_use_case` 和迁移理由。普通资产制作、节点新增、属性写入、UMG/Blueprint/Material/Niagara authoring 不应选择 deprecated 命令。

旧输入拒绝、历史归档和 deprecated 命令边界见 `../../hjson-authoring/06_LegacyMigration.md`。

## Categories

- [anim_blueprint](./anim_blueprint/README.md)
- [animation_assets_skeleton](./animation_assets_skeleton/README.md)
- [blueprint](./blueprint/README.md)
- [control_rig_folder_format](./control_rig_folder_format/README.md)
- [core_level](./core_level/README.md)
- [material](./material/README.md)
- [montage](./montage/README.md)
- [niagara_emitter](./niagara_emitter/README.md)
- [niagara_stage_graph](./niagara_stage_graph/README.md)
- [niagara_system](./niagara_system/README.md)
- [sequence](./sequence/README.md)
- [static_mesh_enhanced_input](./static_mesh_enhanced_input/README.md)
- [umg](./umg/README.md)

- 旧 deprecated 大分册已归档到 `../_legacy_big_docs/deprecated/`。

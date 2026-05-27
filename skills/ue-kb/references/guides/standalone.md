# Standalone 指南

[Reference 入口](../index.md) / [查询指南](querying.md) / [主题地图](../maps/topic-map.md)

当 kbCli、Qdrant、vector service 或索引不可用时，按只读方式使用此 skill。

## 查找顺序

1. [主题地图](../maps/topic-map.md)：确定中文关键词、Unreal 原始术语和真实文档路径。
2. [来源结构](../maps/source-layout.md)：确认顶层文档目录和页面范围。
3. `../../content/markdown/`：优先查构建后的 Markdown mirror。
4. `../../chunks/chunks.jsonl`：查 chunk 级证据和 `chunk_id`。
5. `../../data/normalized/docs.jsonl`：查规范化文档元数据。
6. `../UE5_7Doc/docs/`：查原始 Markdown source。
7. `../Supplemental/`：查 Niagara、Animation、PCG 与 Level Design 补充来源。

## 查询原则

- 使用中文检索词，并保留 API、类名、节点名、属性名、模块名和英文编辑器标签。
- 官方页面 URL 在 Markdown frontmatter 的 `source_url` 中。
- `Supplemental/LevelDesign`、`Supplemental/Niagara`、`Supplemental/Animation` 与 `Supplemental/PCG` 是补充来源，回答时不要当作 Epic 官方文档。
- 回答时引用 `source_path`；如能定位 chunk，再引用 `chunk_id`。

## 禁止事项

- 不直接修改 `content/`、`chunks/`、`indexes/`。
- 不把 standalone 搜索结果说成 Hybrid 检索。
- 不把通用 UE 经验混写成官方文档证据。

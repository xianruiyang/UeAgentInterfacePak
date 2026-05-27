# 维护指南

[Reference 入口](../index.md) / [查询指南](querying.md) / [来源结构](../maps/source-layout.md)

## 边界

- 来源正文在 `references/UE5_7Doc/` 与 `references/Supplemental/`。
- kbCli 主入口是 `kb-manifest.json`。
- `content/`、`chunks/`、`indexes/`、`state/` 和 Qdrant collection 都是派生结果。
- 本机模型路径、provider/device、Qdrant live storage、runtime logs 和 registry 状态不写入 portable skill。

## 重建顺序

更新 `references/UE5_7Doc/` 或 `references/Supplemental/` 后，按顺序刷新：

```powershell
kb source sync --manifest "<this-skill-dir>/kb-manifest.json" --json
kb ingest --manifest "<this-skill-dir>/kb-manifest.json" --changed-only --json
kb chunk --manifest "<this-skill-dir>/kb-manifest.json" --changed-only --json
kb content build --manifest "<this-skill-dir>/kb-manifest.json" --json
kb index build --manifest "<this-skill-dir>/kb-manifest.json" --target fts --json
```

需要 Hybrid 时，再完整构建 vector index，并用 `index verify` 确认 Qdrant collection 完整、新鲜。

## 验证

```powershell
kb validate --manifest "<this-skill-dir>/kb-manifest.json" --json
kb smoke-test --manifest "<this-skill-dir>/kb-manifest.json" --json
kb eval run --manifest "<this-skill-dir>/kb-manifest.json" --suite smoke --json
kb eval coverage --manifest "<this-skill-dir>/kb-manifest.json" --suite smoke --json
kb audit --manifest "<this-skill-dir>/kb-manifest.json" --json
kb package verify --path "<this-skill-dir>" --json
```

`content lint` 可用于检查派生 mirror，但本 skill 的源文档链接/图片应以 `references/UE5_7Doc/` 的独立验证为准。

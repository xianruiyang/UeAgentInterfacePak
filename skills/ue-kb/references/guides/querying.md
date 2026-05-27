# 查询指南

[Reference 入口](../index.md) / [主题地图](../maps/topic-map.md) / [来源结构](../maps/source-layout.md)

## 默认流程

1. 使用 `kb-manifest.json` 显式定位此 skill。
2. 先检查 embedding、vector 和索引状态。
3. 默认尝试 `hybrid`，查询文本使用中文表达用户意图，并保留 Unreal 英文术语、API 名、节点名和编辑器标签。
4. 对关键搜索结果执行 `fetch --include-source --include-links`。
5. 回答时引用 `chunk_id`、`source_path` 和 chunk 中存在的 Epic 原始页面 URL。

```powershell
kb embedding status --manifest "<this-skill-dir>/kb-manifest.json" --json
kb vector status --manifest "<this-skill-dir>/kb-manifest.json" --json
kb index status --manifest "<this-skill-dir>/kb-manifest.json" --json
```

```powershell
kb search --manifest "<this-skill-dir>/kb-manifest.json" --query "<中文问题 + 必要 Unreal 术语>" --language zh-CN --mode hybrid --top-k 8 --candidate-k 40 --json
kb fetch --manifest "<this-skill-dir>/kb-manifest.json" --chunk-id "<chunk_id>" --include-source --include-links --json
```

## Hybrid 判定

此 portable skill 包含 FTS 索引，但 Qdrant vector collection 是本机派生状态，不随 skill 保证存在。只有 `vector status` 和 `index verify` 显示 collection 完整、新鲜时，才把检索结果称为 Hybrid。

如果 Hybrid 不可用，说明缺失依赖，再降级 keyword：

```powershell
kb search --manifest "<this-skill-dir>/kb-manifest.json" --query "<中文问题 + 必要 Unreal 术语>" --language zh-CN --mode keyword --top-k 8 --json
```

不要把 keyword-only 结果描述成 Hybrid 结果。

## 查询写法

- 动画蓝图：`动画蓝图 Animation Blueprint State Machine Blend Space`
- Niagara：`Niagara 导弹 Missile trail Collision Module`
- 关卡白盒：`关卡设计 Whitebox Blockout Metrics Critical Path Loop Landmark Pacing Lock Key`
- 碰撞：`碰撞 Collision Preset Object Channel Trace Channel`
- 网络：`网络复制 Replication RPC Actor Relevancy`
- UI：`UMG CommonUI Activatable Widget Input Action`
- PCG：`PCG Graph Biome Spawner BiomeGeneratorTemplate`

## 证据边界

- 以 fetch 到的官方文档 chunk 为证据主体；Level Design、Niagara、Animation、PCG 补充内容不是 Epic 官方文档，引用时应标注为补充来源。
- 额外推断、实践建议或通用 UE 经验必须明确标注为推断。
- 图片只作为辅助证据；GIF 和动画 WebP 在此文档集中通常以文字占位保留语义。

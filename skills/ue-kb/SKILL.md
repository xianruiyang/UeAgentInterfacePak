---
name: ue-kb
description: 项目本地 Unreal Engine 知识库 skill。以 UE 5.7 官方网页文档 Markdown 转换版为主来源，并包含独立整理的 Niagara、Animation、PCG、Level Design 与 Rendering 补充内容；Niagara 覆盖知识卡和社区实践教程，Rendering 覆盖 Movie Render Graph、Movie Render Queue、Render Pass、Lighting、Lumen、Material 等社区教程；适合 Blueprint、C++、Niagara、Animation、PCG、Level Design/Whitebox、UMG、Physics、Collision、Networking、Editor、Rendering、Asset Pipeline 等版本敏感问题；默认 Hybrid-first、中文 source-language 检索、fetch 后再回答。使用 kbCli 时必须按 kbcli-knowledge-base skill 解析随包 `$KbExe`，不要依赖 PATH 中的 `kb`。此 skill 不会自动安装到 Codex。
---

# UE KB

这是项目本地 KB skill，主来源为 `UeDocRaw/UE5_7LocalDoc` 转换出的 UE 5.7 官方网页文档 Markdown 集，并附带独立整理的 Niagara、Animation、PCG、Level Design 与 Rendering 补充内容。

不要假设此 skill 已安装到 Codex。使用时从项目路径显式定位 manifest。

不要直接调用 PATH 中的 `kb`、registry alias 或源码 checkout 中的 Debug build。此 skill 只声明 UE 知识库的位置、语言和查询约束；kbCli 运行时入口必须交给 `kbcli-knowledge-base` skill 解析。若当前上下文未加载该 skill，先打开 `C:/Users/gzxt/.codex/skills/kbcli-knowledge-base/SKILL.md`，按其“运行时”章节通过 `scripts/resolve-kbcli.ps1` 得到 `$KbExe`、`$VectorExe` 和 `$ModelRegistry`。

首选 manifest：

`kb-manifest.json`

## 范围

- 官方文档来源：Epic Developer Community Unreal Engine 5.7 Documentation 本地整理版。
- Markdown source：`references/UE5_7Doc/docs/...`，外层 `UE5_7Doc` 用于后续在同一 skill 中扩展其他文档集。
- Niagara 补充内容：`references/Supplemental/Niagara/...`，包含知识卡、内置模块整理和社区实践教程，与官方文档分离。
- Animation 补充知识卡：`references/Supplemental/Animation/...`，与官方文档分离。
- PCG 补充专题：`references/Supplemental/PCG/...`，社区教程和实践案例，与官方文档分离。
- Level Design 补充文档：`references/Supplemental/LevelDesign/...`，来自 `leveldesign` skill，用于白盒、Blockout、关卡结构、自动化搭建与审查；不是 Epic 官方文档。
- Rendering 补充专题：`references/Supplemental/Rendering/...`，来自 Epic Developer Community 渲染类社区教程整理，覆盖 Movie Render Graph、Movie Render Queue、Render Pass、Lighting、Lumen、Material、Post Process、Custom Depth 和性能/故障处理；不是官方 UE 5.7 文档正文。
- 资源：`references/UE5_7Doc/assets/...` 只保留精选静态图片；GIF 和动画 WebP 默认不复制，正文中保留文字占位。
- 主语言：中文 `zh-CN`。保留 Unreal API、类名、节点名、属性名、模块名和英文编辑器标签。

## 查询流程

默认使用 Hybrid。查询要用中文表达用户意图，并保留关键 Unreal 英文术语。

先解析两个 skill 路径：

```powershell
$UeKbSkillFile = "<loaded ue-kb SKILL.md full path>"
if (-not (Test-Path -LiteralPath $UeKbSkillFile -PathType Leaf)) {
    $Candidate = Join-Path (Get-Location) "UeAgentInterfacePak\skills\ue-kb\SKILL.md"
    if (Test-Path -LiteralPath $Candidate -PathType Leaf) {
        $UeKbSkillFile = $Candidate
    }
}
if (-not (Test-Path -LiteralPath $UeKbSkillFile -PathType Leaf)) {
    throw "ue-kb skill path unavailable"
}
$UeKbSkillDir = Split-Path -Parent $UeKbSkillFile
$Manifest = Join-Path $UeKbSkillDir "kb-manifest.json"

$KbCliSkillFile = "C:\Users\gzxt\.codex\skills\kbcli-knowledge-base\SKILL.md"
if (-not (Test-Path -LiteralPath $KbCliSkillFile -PathType Leaf)) {
    throw "kbcli-knowledge-base skill unavailable; do not fall back to PATH kb"
}
$KbCliSkillDir = Split-Path -Parent $KbCliSkillFile
$Runtime = & (Join-Path $KbCliSkillDir "scripts\resolve-kbcli.ps1") | ConvertFrom-Json
$KbExe = $Runtime.kb_exe
```

先检查本机检索状态：

```powershell
& $KbExe embedding status --manifest $Manifest --json
& $KbExe vector status --manifest $Manifest --json
& $KbExe index status --manifest $Manifest --json
```

此 portable skill 已包含 FTS 索引；Qdrant vector collection 是本机派生索引，不随 skill 保证存在。只有 `vector status` 与 `index verify` 显示 collection 完整时，才把结果称为 Hybrid。

```powershell
& $KbExe search --manifest $Manifest --query "<中文问题 + 必要 Unreal 术语>" --language zh-CN --mode hybrid --top-k 8 --candidate-k 40 --json
& $KbExe fetch --manifest $Manifest --chunk-id "<chunk_id>" --include-source --include-links --json
```

回答前必须 fetch 关键 chunk。引用 `chunk_id`、`source_path`，以及 chunk 中存在的 Epic 原始页面 URL。

如果 Hybrid 不可用，说明缺失依赖，再降级 keyword：

```powershell
& $KbExe search --manifest $Manifest --query "<中文问题 + 必要 Unreal 术语>" --language zh-CN --mode keyword --top-k 8 --json
```

不要把 keyword-only 结果描述成 Hybrid 结果。

## 按需读取

- Reference 总入口：`references/index.md`
- 查询流程与降级规则：`references/guides/querying.md`
- 主题、关键词和真实来源路径：`references/maps/topic-map.md`
- 顶层来源目录结构：`references/maps/source-layout.md`
- 无 kbCli 或索引不可用时的只读使用方式：`references/guides/standalone.md`
- 原始 Markdown 文档入口：`references/UE5_7Doc/index.md`
- Niagara 补充入口：`references/Supplemental/Niagara/niagara.md`
- Niagara 社区实践专题入口：`references/Supplemental/Niagara/community-practice/README.md`
- PCG 补充专题入口：`references/Supplemental/PCG/README.md`
- Level Design 补充文档入口：`references/Supplemental/LevelDesign/README.md`
- Rendering 补充专题入口：`references/Supplemental/Rendering/README.md`
- 转换报告：`references/UE5_7Doc/conversion-report.json`

## 维护规则

- 不直接编辑 `content/`、`chunks/`、`indexes/` 或 Qdrant 派生索引。
- 更新来源后，重新运行 source sync、ingest、chunk、content build、index build 和验证命令。
- 不把本机模型路径、provider/device、Qdrant live storage、runtime logs 或 registry 状态写入 portable 内容。
- kbCli 维护命令同样必须使用 `kbcli-knowledge-base` skill 解析出的 `$KbExe`。不要把 `kb` 裸命令写回本 skill。

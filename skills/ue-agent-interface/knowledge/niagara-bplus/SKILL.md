---
name: uai-niagara-bplus
description: Knowledge-base skill for UAI Niagara BPlus Tutorials. Use when questions need this local knowledge base, source-backed answers, or version-sensitive documentation lookup.
---

# UAI Niagara BPlus Tutorials

This KB depends on the `kbcli-knowledge-base` skill for the bundled kbCli Release runtime. Do not run a bare `kb` command, do not rely on PATH, and do not use a source checkout Debug build unless the user explicitly asks for it.

Preferred manifest:

`kb-manifest.json`

Preferred alias:

`uai-niagara-bplus`

## Runtime

Resolve kbCli through this KB skill, then use `$KbExe` for every command:

```powershell
$ThisSkillFile = "<loaded this KB SKILL.md full path>"
if (-not (Test-Path -LiteralPath $ThisSkillFile -PathType Leaf)) {
    $ThisSkillFile = Join-Path (Get-Location) "skills\uai-niagara-bplus\SKILL.md"
}
if (-not (Test-Path -LiteralPath $ThisSkillFile -PathType Leaf) -and -not [string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
    $ThisSkillFile = Join-Path $env:USERPROFILE ".codex\skills\uai-niagara-bplus\SKILL.md"
}
if (-not (Test-Path -LiteralPath $ThisSkillFile -PathType Leaf)) {
    throw "KB skill path unavailable; use the loaded SKILL.md path or run from the project root."
}
$ThisSkillDir = Split-Path -Parent $ThisSkillFile
$Runtime = & (Join-Path $ThisSkillDir "scripts\resolve-kbcli-runtime.ps1") | ConvertFrom-Json
$KbExe = $Runtime.kb_exe
$VectorExe = $Runtime.vector_exe
$Manifest = $Runtime.manifest
```

## RAG Path

Use an explicit manifest path. Default to Hybrid and fetch evidence before answering:

```powershell
& $KbExe search --manifest $Manifest --query "<source-language question plus exact identifiers>" --mode hybrid --top-k 8 --candidate-k 40 --json
& $KbExe fetch --manifest $Manifest --chunk-id "<chunk_id>" --include-source --include-links --json
```

## Standalone Read-Only Path

If `kbcli-knowledge-base` or kbCli is unavailable:

- Read `references/standalone-guide.md`.
- Use `references/topic-map.md` to choose keywords and source groups.
- Search `content/markdown/` first, then `chunks/chunks.jsonl`, `data/normalized/docs.jsonl`, and `references/` if needed.
- Cite `chunk_id`, `source_id`, `doc_id`, source path, or source metadata whenever possible.
- Do not modify this knowledge base, rebuild indexes, register aliases, or bind models in standalone mode.

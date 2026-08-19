[CmdletBinding()]
param(
    [string]$KbSkillDir
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($KbSkillDir)) {
    $KbSkillDir = Split-Path -Parent $PSScriptRoot
}

$resolvedKbSkillDir = (Resolve-Path -LiteralPath $KbSkillDir).Path
$manifest = Join-Path $resolvedKbSkillDir "kb-manifest.json"
if (-not (Test-Path -LiteralPath $manifest -PathType Leaf)) {
    throw "KB manifest not found: $manifest"
}

$candidateSkillFiles = @()
if (-not [string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
    $candidateSkillFiles += Join-Path $env:USERPROFILE ".codex\skills\kbcli-knowledge-base\SKILL.md"
}
$candidateSkillFiles += Join-Path (Get-Location) "skills\kbcli-knowledge-base\SKILL.md"
$candidateSkillFiles += Join-Path (Split-Path -Parent $resolvedKbSkillDir) "kbcli-knowledge-base\SKILL.md"

$kbcliSkillFile = $candidateSkillFiles | Where-Object {
    Test-Path -LiteralPath $_ -PathType Leaf
} | Select-Object -First 1

if ([string]::IsNullOrWhiteSpace($kbcliSkillFile)) {
    throw "kbcli-knowledge-base skill not found. Install it to $env:USERPROFILE\.codex\skills\kbcli-knowledge-base or place it beside this KB skill. Do not fall back to a bare kb command."
}

$kbcliSkillDir = Split-Path -Parent $kbcliSkillFile
$resolver = Join-Path $kbcliSkillDir "scripts\resolve-kbcli.ps1"
if (-not (Test-Path -LiteralPath $resolver -PathType Leaf)) {
    throw "kbcli resolver not found: $resolver"
}

$runtime = & $resolver | ConvertFrom-Json
[ordered]@{
    ok = $true
    kb_skill_dir = $resolvedKbSkillDir
    manifest = $manifest
    kbcli_skill_dir = $kbcliSkillDir
    kb_exe = $runtime.kb_exe
    vector_exe = $runtime.vector_exe
    model_registry = $runtime.model_registry
} | ConvertTo-Json -Depth 4

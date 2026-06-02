param(
  [Parameter(Mandatory = $true)][string]$UserWorkDir,
  [int]$TmpThreshold = 120,
  [int]$TmpKeep = 40,
  [int]$ReportThreshold = 200,
  [int]$ReportKeep = 120,
  [switch]$Apply
)

$ErrorActionPreference = 'Stop'

function Resolve-ChildPath {
  param(
    [Parameter(Mandatory = $true)][string]$Root,
    [Parameter(Mandatory = $true)][string]$RelativePath
  )

  $rootFull = [System.IO.Path]::GetFullPath($Root)
  $childFull = [System.IO.Path]::GetFullPath((Join-Path $rootFull $RelativePath))
  $rootWithSlash = $rootFull.TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar

  if (-not $childFull.StartsWith($rootWithSlash, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "refusing path outside UserWorkDir: $childFull"
  }

  return $childFull
}

function Trim-Files {
  param(
    [string]$Path,
    [string]$Filter,
    [int]$Threshold,
    [int]$Keep
  )

  if (-not (Test-Path -LiteralPath $Path)) {
    return [pscustomobject]@{ path = $Path; total = 0; would_remove = 0; removed = 0; kept = 0; skipped = $true }
  }

  $files = Get-ChildItem -LiteralPath $Path -File -Filter $Filter | Sort-Object LastWriteTime -Descending
  $total = $files.Count
  if ($total -le $Threshold) {
    return [pscustomobject]@{ path = $Path; total = $total; would_remove = 0; removed = 0; kept = $total; skipped = $false }
  }

  $toRemove = $files | Select-Object -Skip $Keep
  $removed = 0
  if ($Apply) {
    foreach ($f in $toRemove) {
      Remove-Item -LiteralPath $f.FullName -Force -ErrorAction Stop
      $removed += 1
    }
  }

  return [pscustomobject]@{
    path = $Path
    total = $total
    would_remove = $toRemove.Count
    removed = $removed
    kept = [Math]::Min($Keep, $total)
    skipped = $false
  }
}

$root = (Resolve-Path -LiteralPath $UserWorkDir).Path
$tmpDir = Resolve-ChildPath -Root $root -RelativePath 'tmp\uai_params'
$reportDir = Resolve-ChildPath -Root $root -RelativePath 'runtimeLogs'

$r1 = Trim-Files -Path $tmpDir -Filter '*.json' -Threshold $TmpThreshold -Keep $TmpKeep
$r2 = Trim-Files -Path $reportDir -Filter '*.json' -Threshold $ReportThreshold -Keep $ReportKeep

[pscustomobject]@{
  user_work_dir = $root
  apply = [bool]$Apply
  tmp = $r1
  reports = $r2
} | ConvertTo-Json -Depth 5

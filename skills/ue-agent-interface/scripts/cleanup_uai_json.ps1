param(
  [Parameter(Mandatory = $true)][string]$ProjectRoot,
  [int]$TmpThreshold = 120,
  [int]$TmpKeep = 40,
  [int]$ReportThreshold = 200,
  [int]$ReportKeep = 120
)

$ErrorActionPreference = 'Stop'

function Trim-Files {
  param(
    [string]$Path,
    [string]$Filter,
    [int]$Threshold,
    [int]$Keep
  )

  if (-not (Test-Path -LiteralPath $Path)) {
    return [pscustomobject]@{ path = $Path; total = 0; removed = 0; kept = 0; skipped = $true }
  }

  $files = Get-ChildItem -LiteralPath $Path -File -Filter $Filter | Sort-Object LastWriteTime -Descending
  $total = $files.Count
  if ($total -le $Threshold) {
    return [pscustomobject]@{ path = $Path; total = $total; removed = 0; kept = $total; skipped = $false }
  }

  $toRemove = $files | Select-Object -Skip $Keep
  foreach ($f in $toRemove) {
    Remove-Item -LiteralPath $f.FullName -Force -ErrorAction Stop
  }

  return [pscustomobject]@{ path = $Path; total = $total; removed = $toRemove.Count; kept = [Math]::Min($Keep, $total); skipped = $false }
}

$tmpDir = Join-Path $ProjectRoot 'UeAgentInterfaceCMD\tmp'
$reportDir = Join-Path $ProjectRoot 'UeAgentInterfaceCMD\dist\reports'

$r1 = Trim-Files -Path $tmpDir -Filter '*.json' -Threshold $TmpThreshold -Keep $TmpKeep
$r2 = Trim-Files -Path $reportDir -Filter '*.json' -Threshold $ReportThreshold -Keep $ReportKeep

[pscustomobject]@{
  project_root = $ProjectRoot
  tmp = $r1
  reports = $r2
} | ConvertTo-Json -Depth 5

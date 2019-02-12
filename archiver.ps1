<#
.SYNOPSIS
TODO
.DESCRIPTION
TODO
.PARAMETER Days
TODO
#>

<#
!Warning!
Only works in PowerShell 5.0 and newer.
#>

param(
[Parameter(Mandatory=$true, HelpMessage="Files not touched in -Days will be zipped.")]
[int] $Days = 2
)

$filter = [datetime]::Now.AddDays(-1*$Days);

$files = Get-ChildItem -File | Where-Object { $_.LastWriteTime -lt $filter }

if ($files -eq $null) {
  return;
}
$target = (Get-Date).ToShortDateString() + ".zip";

$files | Compress-Archive -DestinationPath $target;
Write-Host "Compressed the following files into" $target;
$files | ForEach-Object { Write-Host $_.Name " " -NoNewline };
Write-Host "";

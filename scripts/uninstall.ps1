param(
    [string]$Target = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

$libPath = $null
if ($PSScriptRoot) {
    $libPath = Join-Path $PSScriptRoot "lib.ps1"
}
if ($libPath -and (Test-Path -LiteralPath $libPath)) {
    . $libPath
}
else {
    $libUrl = "https://raw.githubusercontent.com/meowthpxnk/violence_agency/master/scripts/lib.ps1"
    $libFile = Join-Path ([System.IO.Path]::GetTempPath()) "violence-agency-lib.ps1"
    Invoke-WebRequest -Uri $libUrl -OutFile $libFile -UseBasicParsing
    . $libFile
}
Uninstall-AgentKit -Target $Target

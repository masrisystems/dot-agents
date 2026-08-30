<#
.SYNOPSIS
Restores Claude Code marketplaces and user-scope plugins from config/plugins.json.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$manifest = Join-Path $PSScriptRoot "..\config\plugins.json"

if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Warning "Claude Code CLI not found in PATH. Skipping plugin restore."
    return
}
if (-not (Test-Path $manifest)) {
    Write-Warning "No plugin manifest at $manifest. Skipping."
    return
}

$data = Get-Content $manifest -Raw | ConvertFrom-Json

foreach ($name in $data.marketplaces.PSObject.Properties.Name) {
    $repo = $data.marketplaces.$name
    Write-Host "Adding marketplace $name ($repo)..." -ForegroundColor Cyan
    claude plugin marketplace add $repo
}

foreach ($plugin in $data.plugins) {
    Write-Host "Installing $plugin..." -ForegroundColor Cyan
    claude plugin install $plugin
}

Write-Host "Plugin restore complete." -ForegroundColor Green

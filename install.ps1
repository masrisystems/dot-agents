<#
.SYNOPSIS
One-line automated installer for Masri Systems Portable Agent Hub on Windows.
#>
[CmdletBinding()]
param(
    [string]$RepoUrl = "https://github.com/masrisystems/dot-agents.git"
)

$ErrorActionPreference = 'Stop'
$targetDir = Join-Path $HOME ".agents"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   Masri Systems Portable Multi-Agent Hub Installer       " -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is required but not installed or not in PATH."
    exit 1
}

if (-not (Test-Path $targetDir)) {
    Write-Host "Cloning agent hub into $targetDir..." -ForegroundColor Cyan
    git clone $RepoUrl $targetDir
} else {
    Write-Host "Directory $targetDir already exists. Pulling latest..." -ForegroundColor Cyan
    Set-Location $targetDir
    git pull origin main --ff-only
}

Set-Location $targetDir

if (Test-Path "$targetDir\sync.ps1") {
    Write-Host "Applying synchronization across Antigravity, Claude, and Codex..." -ForegroundColor Cyan
    & "$targetDir\sync.ps1" -Apply
}

Write-Host ""
Write-Host "✓ Installation complete! Your AI agent hub is synchronized and active." -ForegroundColor Green
Write-Host "  Canonical Directory: $targetDir" -ForegroundColor Gray
Write-Host "  Active Skills:       $targetDir\skills" -ForegroundColor Gray
Write-Host "  Catalog & Explorer:  $targetDir\catalogs\manage-catalog.ps1" -ForegroundColor Gray

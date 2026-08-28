<#
.SYNOPSIS
Manage and dynamically link/unlink skills, agents, and commands from the ECC catalog.
#>
param(
    [string]$Search,
    [string]$EnableSkill,
    [string]$DisableSkill,
    [switch]$ListActive,
    [switch]$Summary
)

$baseDir = "C:\Users\super\.agents"
$catalogDir = "$baseDir\catalogs\ecc"
$skillsDir = "$baseDir\skills"
$skillsIndexFile = "$baseDir\catalogs\skills-index.json"
$agentsIndexFile = "$baseDir\catalogs\agents-index.json"
$commandsIndexFile = "$baseDir\catalogs\commands-index.json"

if ($Summary -or (-not $Search -and -not $EnableSkill -and -not $DisableSkill -and -not $ListActive)) {
    $skills = Get-Content $skillsIndexFile -Raw | ConvertFrom-Json
    $agents = Get-Content $agentsIndexFile -Raw | ConvertFrom-Json
    $commands = Get-Content $commandsIndexFile -Raw | ConvertFrom-Json
    $active = Get-ChildItem $skillsDir -Directory
    
    Write-Host "=================================================" -ForegroundColor Cyan
    Write-Host "   ECC CATALOG & SKILLS REPOSITORY SUMMARY      " -ForegroundColor Yellow
    Write-Host "=================================================" -ForegroundColor Cyan
    Write-Host " Catalog Path:     $catalogDir"
    Write-Host " Catalog Skills:   $($skills.Count)"
    Write-Host " Catalog Agents:   $($agents.Count)"
    Write-Host " Catalog Commands: $($commands.Count)"
    Write-Host " Active Skills:    $($active.Count) (in $skillsDir)"
    Write-Host ""
    Write-Host "Usage:"
    Write-Host "  .\manage-catalog.ps1 -Search <keyword>     Search skills, agents, commands"
    Write-Host "  .\manage-catalog.ps1 -EnableSkill <name>   Activate a skill into .agents/skills"
    Write-Host "  .\manage-catalog.ps1 -DisableSkill <name>  Deactivate a skill"
    Write-Host "  .\manage-catalog.ps1 -ListActive           Show currently active skills"
    exit 0
}

if ($Search) {
    Write-Host "Searching catalog for '$Search'..." -ForegroundColor Cyan
    $skills = Get-Content $skillsIndexFile -Raw | ConvertFrom-Json
    $agents = Get-Content $agentsIndexFile -Raw | ConvertFrom-Json
    $commands = Get-Content $commandsIndexFile -Raw | ConvertFrom-Json

    $matchedSkills = $skills | Where-Object { $_.Name -like "*$Search*" -or $_.Description -like "*$Search*" }
    $matchedAgents = $agents | Where-Object { $_.Name -like "*$Search*" -or $_.Description -like "*$Search*" }
    $matchedCmds = $commands | Where-Object { $_.Name -like "*$Search*" -or $_.Description -like "*$Search*" }

    Write-Host "`n--- Matched Skills ($($matchedSkills.Count)) ---" -ForegroundColor Green
    foreach ($s in $matchedSkills | Select-Object -First 15) {
        $desc = if ($s.Description.Length -gt 80) { $s.Description.Substring(0, 77) + "..." } else { $s.Description }
        Write-Host "  * $($s.Name)" -ForegroundColor Yellow -NoNewline
        Write-Host " - $desc" -ForegroundColor Gray
    }

    Write-Host "`n--- Matched Agents ($($matchedAgents.Count)) ---" -ForegroundColor Blue
    foreach ($a in $matchedAgents | Select-Object -First 10) {
        $desc = if ($a.Description.Length -gt 80) { $a.Description.Substring(0, 77) + "..." } else { $a.Description }
        Write-Host "  * $($a.Name)" -ForegroundColor Yellow -NoNewline
        Write-Host " - $desc" -ForegroundColor Gray
    }

    Write-Host "`n--- Matched Commands ($($matchedCmds.Count)) ---" -ForegroundColor Magenta
    foreach ($c in $matchedCmds | Select-Object -First 10) {
        Write-Host "  * $($c.Name)" -ForegroundColor Yellow -NoNewline
        Write-Host " ($($c.RelativePath))" -ForegroundColor Gray
    }
}

if ($EnableSkill) {
    $srcPath = "$catalogDir\skills\$EnableSkill"
    $destPath = "$skillsDir\$EnableSkill"

    if (-not (Test-Path $srcPath)) {
        Write-Error "Skill '$EnableSkill' not found in catalog ($srcPath)"
        exit 1
    }

    if (Test-Path $destPath) {
        Write-Host "Skill '$EnableSkill' is already active at $destPath" -ForegroundColor Yellow
        exit 0
    }

    Write-Host "Linking skill '$EnableSkill' into $skillsDir..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $destPath -Force | Out-Null
    Copy-Item -Path "$srcPath\*" -Destination $destPath -Recurse -Force
    Write-Host "✓ Enabled skill '$EnableSkill'. Running sync..." -ForegroundColor Green
    & "$baseDir\sync.ps1" -Apply
}

if ($DisableSkill) {
    $destPath = "$skillsDir\$DisableSkill"
    if (-not (Test-Path $destPath)) {
        Write-Host "Skill '$DisableSkill' is not in $skillsDir" -ForegroundColor Yellow
        exit 0
    }

    Write-Host "Removing skill '$DisableSkill' from $skillsDir..." -ForegroundColor Cyan
    Remove-Item -Path $destPath -Recurse -Force
    Write-Host "✓ Disabled skill '$DisableSkill'. Running sync..." -ForegroundColor Green
    & "$baseDir\sync.ps1" -Apply
}

if ($ListActive) {
    Write-Host "Currently Active Skills in $($skillsDir):" -ForegroundColor Cyan
    Get-ChildItem $skillsDir -Directory | ForEach-Object {
        Write-Host "  * $($_.Name)" -ForegroundColor Green
    }
}

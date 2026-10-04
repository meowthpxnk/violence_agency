$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$script:DefaultRepoUrl = "https://github.com/meowthpxnk/violence_agency"
$script:DefaultRef = "master"
$script:BackupName = ".cursor.backup"
$script:LegacyBackupName = ".cursor.bak"

function Get-TargetRoot {
    param([string]$Target)
    if (-not (Test-Path -LiteralPath $Target)) {
        throw "Project folder does not exist: $Target"
    }
    return (Resolve-Path -LiteralPath $Target).Path
}

function Get-ArchiveUrl {
    param([string]$RepoUrl, [string]$Ref)
    if ($RepoUrl -match "^https://github\.com/([^/]+)/([^/]+?)(?:\.git)?/?$") {
        $owner = $Matches[1]
        $repo = $Matches[2]
        return "https://github.com/$owner/$repo/archive/refs/heads/$Ref.zip"
    }
    throw "RepoUrl must look like https://github.com/owner/repo"
}

function Get-RemoteCursor {
    param([string]$RepoUrl, [string]$Ref)
    $archiveUrl = Get-ArchiveUrl -RepoUrl $RepoUrl -Ref $Ref
    $tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("violence-agency-" + [guid]::NewGuid().ToString("n"))
    New-Item -ItemType Directory -Path $tempRoot | Out-Null
    $zipPath = Join-Path $tempRoot "kit.zip"
    $extractPath = Join-Path $tempRoot "src"
    Invoke-WebRequest -Uri $archiveUrl -OutFile $zipPath -UseBasicParsing
    Expand-Archive -LiteralPath $zipPath -DestinationPath $extractPath
    $found = Get-ChildItem -LiteralPath $extractPath -Recurse -Directory -Force |
        Where-Object { $_.Name -eq ".cursor" } |
        Select-Object -First 1
    if (-not $found) {
        throw "The downloaded archive has no .cursor directory."
    }
    return $found.FullName
}

function Get-LocalCursor {
    if (-not $PSScriptRoot) {
        return $null
    }
    $candidate = Join-Path (Split-Path -Parent $PSScriptRoot) ".cursor"
    if (Test-Path -LiteralPath $candidate) {
        return (Resolve-Path -LiteralPath $candidate).Path
    }
    return $null
}

function Copy-CursorToStaging {
    param([string]$SourceCursor)
    $stageRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("violence-agency-stage-" + [guid]::NewGuid().ToString("n"))
    New-Item -ItemType Directory -Path $stageRoot | Out-Null
    Copy-Item -LiteralPath $SourceCursor -Destination (Join-Path $stageRoot ".cursor") -Recurse -Force
    return (Join-Path $stageRoot ".cursor")
}

function Resolve-CursorSource {
    param(
        [string]$RepoUrl,
        [string]$Ref,
        [switch]$RemoteOnly
    )
    if ($RemoteOnly -or $RepoUrl) {
        if (-not $RepoUrl) {
            $RepoUrl = $script:DefaultRepoUrl
        }
        if (-not $Ref) {
            $Ref = $script:DefaultRef
        }
        return Get-RemoteCursor -RepoUrl $RepoUrl -Ref $Ref
    }
    $local = Get-LocalCursor
    if ($local) {
        return $local
    }
    return Get-RemoteCursor -RepoUrl $script:DefaultRepoUrl -Ref $(if ($Ref) { $Ref } else { $script:DefaultRef })
}

function Install-CursorInto {
    param([string]$StagedCursor, [string]$TargetRoot)
    $destination = Join-Path $TargetRoot ".cursor"
    if (Test-Path -LiteralPath $destination) {
        Remove-Item -LiteralPath $destination -Recurse -Force
    }
    Move-Item -LiteralPath $StagedCursor -Destination $destination
}

function Install-AgentKit {
    param([string]$Target, [string]$RepoUrl, [string]$Ref)
    $targetRoot = Get-TargetRoot -Target $Target
    $destination = Join-Path $targetRoot ".cursor"
    $backup = Join-Path $targetRoot $script:BackupName
    if (Test-Path -LiteralPath $backup) {
        throw "Backup already exists: $backup. Restore or delete it before installing again."
    }
    $source = Resolve-CursorSource -RepoUrl $RepoUrl -Ref $Ref
    $staged = Copy-CursorToStaging -SourceCursor $source
    if (Test-Path -LiteralPath $destination) {
        Rename-Item -LiteralPath $destination -NewName $script:BackupName
        Write-Host "Moved the existing .cursor to $script:BackupName"
    }
    Install-CursorInto -StagedCursor $staged -TargetRoot $targetRoot
    Write-Host "Installed agents into $destination"
}

function Update-AgentKit {
    param([string]$Target, [string]$RepoUrl, [string]$Ref)
    $targetRoot = Get-TargetRoot -Target $Target
    $source = Resolve-CursorSource -RepoUrl $RepoUrl -Ref $Ref -RemoteOnly
    $staged = Copy-CursorToStaging -SourceCursor $source
    Install-CursorInto -StagedCursor $staged -TargetRoot $targetRoot
    Write-Host "Updated agents in $(Join-Path $targetRoot '.cursor')"
}

function Uninstall-AgentKit {
    param([string]$Target)
    $targetRoot = Get-TargetRoot -Target $Target
    $destination = Join-Path $targetRoot ".cursor"
    if (Test-Path -LiteralPath $destination) {
        Remove-Item -LiteralPath $destination -Recurse -Force
        Write-Host "Removed $destination"
    }
    $backup = Join-Path $targetRoot $script:BackupName
    $legacy = Join-Path $targetRoot $script:LegacyBackupName
    if (Test-Path -LiteralPath $backup) {
        Rename-Item -LiteralPath $backup -NewName ".cursor"
        Write-Host "Restored $script:BackupName to .cursor"
    }
    elseif (Test-Path -LiteralPath $legacy) {
        Rename-Item -LiteralPath $legacy -NewName ".cursor"
        Write-Host "Restored $script:LegacyBackupName to .cursor"
    }
    else {
        Write-Host "No backup folder to restore."
    }
}

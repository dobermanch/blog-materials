<#
    Cleanup script for Docker Desktop on Windows.
    - Removes unused Docker images, containers, and volumes
    - Shuts down WSL to release file locks
    - Detects ALL Docker VHDX locations (old + new layouts)
    - Compacts each VHDX to reclaim disk space
    - Asks before installing Hyper-V if missing
#>

$ok = "[OK]"
$info = "[INFO]"
$warn = "[WARN]"
$err = "[ERROR]"

Write-Host "$info Cleaning up Docker data..." -ForegroundColor Cyan
docker system prune -a --volumes -f

Write-Host "$info Shutting down WSL..." -ForegroundColor Cyan
wsl --shutdown

# Known Docker VHDX locations
$paths = @(
    "$env:LOCALAPPDATA\Docker\wsl\data\ext4.vhdx",          # old layout
    "$env:LOCALAPPDATA\Docker\wsl\disk\docker_data.vhdx"    # new layout
)

# Find all existing VHDX files
$foundVhds = $paths | Where-Object { Test-Path $_ }

if (-not $foundVhds) {
    Write-Host "$warn No Docker VHDX files found in known locations." -ForegroundColor Yellow
    return
}

# Check for Hyper-V module
if (-not (Get-Module -ListAvailable -Name Hyper-V)) {
    Write-Host "$warn Hyper-V module not found. Required for Optimize-VHD." -ForegroundColor Yellow
    $answer = Read-Host "Install Hyper-V now? (y/n)"

    if ($answer -ne "y") {
        Write-Host "$err Hyper-V not installed. Cannot compact VHD files. Exiting." -ForegroundColor Red
        return
    }

    Write-Host "$info Installing Hyper-V..." -ForegroundColor Cyan
    try {
        Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -ErrorAction Stop
        Write-Host "$ok Hyper-V installed." -ForegroundColor Green
    } catch {
        Write-Host "$err Failed to install Hyper-V. Cannot continue." -ForegroundColor Red
        return
    }
}

foreach ($vhd in $foundVhds) {
    Write-Host "$info Compacting VHDX: $vhd" -ForegroundColor Cyan
    try {
        Optimize-VHD -Path $vhd -Mode Full
        Write-Host "$ok Successfully compacted: $vhd" -ForegroundColor Green
    } catch {
        Write-Host "$err Failed to compact: $vhd" -ForegroundColor Red
    }
}

Write-Host "$ok Done. Disk space reclaimed." -ForegroundColor Green
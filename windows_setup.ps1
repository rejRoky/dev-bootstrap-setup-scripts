#Requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "==> Installing winget packages" -ForegroundColor Cyan

# Install winget if not available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Installing winget..."
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
}

# Dev tools
$devTools = @(
    "Git.Git"
    "GitHub.cli"
    "Microsoft.VisualStudioCode"
    "Microsoft.WindowsTerminal"
    "Python.Python.3.12"
    "OpenJS.NodeJS.LTS"
    "Docker.DockerDesktop"
    "Microsoft.PowerShell"
)

# Utilities
$utilities = @(
    "7zip.7zip"
    "WinSCP.WinSCP"
    "PuTTY.PuTTY"
    "Notepad++.Notepad++"
    "WinMerge.WinMerge"
    "voidtools.Everything"
    "Microsoft.PowerToys"
)

# Desktop & media
$media = @(
    "VideoLAN.VLC"
    "GIMP.GIMP"
    "Mozilla.Firefox"
    "Google.Chrome"
)

Write-Host "==> Installing dev tools" -ForegroundColor Cyan
foreach ($app in $devTools) {
    Write-Host "  Installing $app..."
    winget install --id $app --accept-source-agreements --accept-package-agreements --silent 2>$null
}

Write-Host "==> Installing utilities" -ForegroundColor Cyan
foreach ($app in $utilities) {
    Write-Host "  Installing $app..."
    winget install --id $app --accept-source-agreements --accept-package-agreements --silent 2>$null
}

Write-Host "==> Installing desktop & media" -ForegroundColor Cyan
foreach ($app in $media) {
    Write-Host "  Installing $app..."
    winget install --id $app --accept-source-agreements --accept-package-agreements --silent 2>$null
}

Write-Host "==> Setting up WSL" -ForegroundColor Cyan
wsl --install -d Ubuntu --no-launch

Write-Host "==> Enabling developer mode" -ForegroundColor Cyan
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1" 2>$null

Write-Host "==> Refreshing PATH" -ForegroundColor Cyan
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

Write-Host "==> Done! Please reboot for all changes to take effect." -ForegroundColor Green

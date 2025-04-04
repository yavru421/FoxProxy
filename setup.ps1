# Firefox Control Tools Setup Script

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Please run this script as Administrator for full functionality" -ForegroundColor Yellow
    Write-Host "Some features may not work correctly without administrative privileges" -ForegroundColor Yellow
    Write-Host "Press Enter to continue anyway, or Ctrl+C to cancel..."
    Read-Host
}

Write-Host "Firefox Control Tools Setup" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan
Write-Host ""

# Check for Firefox installation
$firefoxPath = "C:\Program Files\Mozilla Firefox\firefox.exe"
$firefoxFound = Test-Path $firefoxPath

if ($firefoxFound) {
    Write-Host "✓ Firefox found at: $firefoxPath" -ForegroundColor Green
} else {
    Write-Host "✗ Firefox not found at default location!" -ForegroundColor Red
    Write-Host "  Please install Firefox from https://www.mozilla.org/firefox/" -ForegroundColor Yellow
}

# Check if Selenium module is installed (for Selenium-based scripts)
$seleniumInstalled = Get-Module -ListAvailable -Name Selenium

if ($seleniumInstalled) {
    Write-Host "✓ Selenium PowerShell module is installed" -ForegroundColor Green
} else {
    Write-Host "× Selenium PowerShell module is not installed" -ForegroundColor Yellow
    
    $installSelenium = Read-Host "Do you want to install the Selenium module now? (Y/N)"
    if ($installSelenium -eq 'Y' -or $installSelenium -eq 'y') {
        try {
            Write-Host "Installing Selenium module..." -ForegroundColor Cyan
            Install-Module -Name Selenium -Force -Scope CurrentUser
            Write-Host "✓ Selenium module installed successfully" -ForegroundColor Green
        }
        catch {
            Write-Host "✗ Failed to install Selenium module: $_" -ForegroundColor Red
            Write-Host "  You can install it manually with: Install-Module -Name Selenium -Force" -ForegroundColor Yellow
        }
    }
}

# Create a shortcut to fox.cmd in Start Menu for easy access
$startMenuPath = [System.Environment]::GetFolderPath('StartMenu')
$programsPath = Join-Path -Path $startMenuPath -ChildPath 'Programs'
$shortcutPath = Join-Path -Path $programsPath -ChildPath 'FoxProxy.lnk'

try {
    $foxCmdPath = Join-Path -Path $PSScriptRoot -ChildPath 'cli\fox.cmd'
    
    if (Test-Path $foxCmdPath) {
        $WshShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($shortcutPath)
        $Shortcut.TargetPath = "cmd.exe"
        $Shortcut.Arguments = "/c `"$foxCmdPath`" -Action info"
        $Shortcut.WorkingDirectory = (Split-Path $foxCmdPath)
        $Shortcut.Description = "Firefox Control Command Line Interface"
        $Shortcut.Save()
        
        Write-Host "✓ Created shortcut in Start Menu" -ForegroundColor Green
    } else {
        Write-Host "✗ Could not find fox.cmd at: $foxCmdPath" -ForegroundColor Red
    }
}
catch {
    Write-Host "✗ Failed to create shortcut: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "Setup completed!" -ForegroundColor Green
Write-Host "To use FoxProxy, navigate to the cli directory and run fox.cmd" -ForegroundColor White
Write-Host "Example: cd cli && fox.cmd -Action info" -ForegroundColor White
Write-Host ""

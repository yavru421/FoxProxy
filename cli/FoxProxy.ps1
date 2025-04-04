# FoxProxy - Firefox Command Proxy
# Simple command-based Firefox control without complex protocols

param (
    [Parameter(Mandatory=$false)]
    [string]$Action = "info",
    
    [Parameter(Mandatory=$false)]
    [string]$Url,
    
    [Parameter(Mandatory=$false)]
    [string]$Query,
    
    [Parameter(Mandatory=$false)]
    [string]$Tab = "current"
)

# Find active Firefox instance
function Get-FirefoxProcessInfo {
    $firefoxProcesses = Get-Process firefox -ErrorAction SilentlyContinue | 
                        Select-Object Id, MainWindowTitle, StartTime
    
    if ($firefoxProcesses) {
        Write-Host "Found Firefox processes:" -ForegroundColor Cyan
        $firefoxProcesses | Format-Table -AutoSize
        
        # Return the process with a window title if possible
        $mainProcess = $firefoxProcesses | Where-Object { $_.MainWindowTitle -ne "" } | Select-Object -First 1
        if ($mainProcess) {
            return $mainProcess
        } else {
            # Otherwise just return the first process
            return $firefoxProcesses[0]
        }
    } else {
        Write-Host "No Firefox processes found" -ForegroundColor Yellow
        return $null
    }
}

# Send command to Firefox
function Send-FirefoxCommand {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Command,
        
        [Parameter(Mandatory=$false)]
        [string[]]$Arguments
    )
    
    try {
        $argString = $Arguments -join " "
        $fullCommand = "firefox.exe $Command $argString"
        
        Write-Host "Executing: $fullCommand" -ForegroundColor DarkGray
        
        if ($Arguments -and $Arguments.Count -gt 0) {
            $allArgs = @($Command) + $Arguments
            Start-Process "firefox.exe" -ArgumentList $allArgs -WindowStyle Normal
        } else {
            Start-Process "firefox.exe" -ArgumentList $Command -WindowStyle Normal
        }
        
        # Give Firefox time to process the command
        Start-Sleep -Seconds 1
        
        return $true
    }
    catch {
        Write-Error "Failed to execute Firefox command: $_"
        return $false
    }
}

# Main execution
$firefox = Get-FirefoxProcessInfo

# Execute action
switch ($Action) {
    "info" {
        if ($firefox) {
            Write-Host "Firefox main process:" -ForegroundColor Cyan
            Write-Host "  PID: $($firefox.Id)" -ForegroundColor White
            Write-Host "  Title: $($firefox.MainWindowTitle)" -ForegroundColor White
            Write-Host "  Started: $($firefox.StartTime)" -ForegroundColor White
        } else {
            Write-Host "Firefox is not running" -ForegroundColor Yellow
        }
    }
    
    "open" {
        if (-not $Url) {
            Write-Error "URL parameter is required for open action"
            break
        }
        
        # Determine tab parameter
        $tabArg = switch ($Tab) {
            "new" { "-new-window" }
            "tab" { "-new-tab" }
            default { "-new-tab" }
        }
        
        Send-FirefoxCommand -Command $tabArg -Arguments $Url
        Write-Host "Opened $Url in $Tab" -ForegroundColor Green
    }
    
    "search" {
        if (-not $Query) {
            Write-Error "Query parameter is required for search action"
            break
        }
        
        # Encode query for URL
        $encodedQuery = [System.Uri]::EscapeDataString($Query)
        $searchUrl = "https://www.google.com/search?q=$encodedQuery"
        
        # Determine tab parameter
        $tabArg = switch ($Tab) {
            "new" { "-new-window" }
            "tab" { "-new-tab" }
            default { "-new-tab" }
        }
        
        Send-FirefoxCommand -Command $tabArg -Arguments $searchUrl
        Write-Host "Searching for: $Query" -ForegroundColor Green
    }
    
    "reload" {
        Send-FirefoxCommand -Command "-new-instance"
        Write-Host "Reloaded Firefox" -ForegroundColor Green
    }
    
    "private" {
        if ($Url) {
            Send-FirefoxCommand -Command "-private-window" -Arguments $Url
            Write-Host "Opened private window with $Url" -ForegroundColor Green
        } else {
            Send-FirefoxCommand -Command "-private-window"
            Write-Host "Opened private window" -ForegroundColor Green
        }
    }
    
    "quit" {
        if ($firefox) {
            Stop-Process -Id $firefox.Id -Force
            Write-Host "Firefox terminated" -ForegroundColor Green
        } else {
            Write-Host "Firefox is not running" -ForegroundColor Yellow
        }
    }
    
    "restart" {
        if ($firefox) {
            Stop-Process -Id $firefox.Id -Force
            Start-Sleep -Seconds 2
            Send-FirefoxCommand -Command "-new-instance"
            Write-Host "Firefox restarted" -ForegroundColor Green
        } else {
            Send-FirefoxCommand -Command "-new-instance"
            Write-Host "Firefox started" -ForegroundColor Green
        }
    }
    
    default {
        Write-Error "Unknown action: $Action"
        Write-Host "Available actions: info, open, search, reload, private, quit, restart" -ForegroundColor Yellow
    }
}

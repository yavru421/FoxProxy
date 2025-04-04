param (
    [Parameter(Mandatory=$false)]
    [string]$Url = "https://www.google.com"
)

# Simply start Firefox and navigate to the specified URL
try {
    Write-Host "Starting Firefox and navigating to $Url..."
    Start-Process "firefox.exe" -ArgumentList $Url
    Write-Host "Firefox started successfully!"
} catch {
    Write-Host "Error starting Firefox: $_" -ForegroundColor Red
}

# Selenium-based Firefox Automation Scripts

More powerful Firefox automation scripts using Selenium WebDriver for complex interactions.

## Overview

These scripts use the Selenium PowerShell module to automate Firefox for tasks that require direct interaction with web page elements, like:

- Form filling and submission
- Button clicks and element interaction
- JavaScript execution
- Screenshot capture
- Complex automation workflows
- Content extraction

## Available Scripts

### send_facebook_message.ps1

Automates sending messages through Facebook Messenger.

```powershell
.\send_facebook_message.ps1 -Recipient "username" -Message "Hello world!"
```

## Setup

Before using these scripts, you need to install the Selenium PowerShell module:

```powershell
Install-Module -Name Selenium -Force
```

You'll also need to ensure Firefox is installed on your system.

## Creating New Scripts

When creating new automation scripts:

1. Start with this template:

```powershell
# Import Selenium module
Import-Module Selenium

# Initialize Firefox
$driver = Start-SeFirefox

# Navigate to a website
Enter-SeUrl -Driver $driver -Url "https://example.com"

# Interact with elements
Find-SeElement -Driver $driver -Id "elementId" | Invoke-SeClick

# Close driver when done
Stop-SeDriver -Driver $driver
```

2. Use these common Selenium commands:

| Action | Command |
|--------|---------|
| Navigate | `Enter-SeUrl -Driver $driver -Url "https://example.com"` |
| Find element | `Find-SeElement -Driver $driver -Id "elementId"` |
| Click element | `Find-SeElement -Driver $driver -Id "elementId" | Invoke-SeClick` |
| Type text | `Find-SeElement -Driver $driver -Id "inputId" | Send-SeKeys -Keys "text to type"` |
| Execute JS | `Invoke-SeJavaScript -Driver $driver -Script "return document.title"` |
| Take screenshot | `Save-SeScreenshot -Driver $driver -Path "screenshot.png"` |

## Error Handling

Always include proper error handling in your scripts:

```powershell
try {
    # Automation code
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    # Always close the driver
    if ($driver) {
        Stop-SeDriver -Driver $driver
    }
}
```

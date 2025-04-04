# Firefox Control Tools

A collection of PowerShell-based tools for controlling and automating Firefox browser instances.

## Overview

Firefox Control Tools provides multiple approaches to Firefox automation:

1. **FoxProxy (Command-line)**: Lightweight command-line interface for controlling Firefox using native command-line arguments
2. **Selenium-based Scripts**: More powerful automation using Selenium WebDriver for complex interactions
3. **Workflow System**: JSON-based workflow configurations for common automation tasks

## Repository Structure

- `cli/` - Command-line interface tools
  - FoxProxy for simple Firefox control via command line
  - No complex dependencies, just PowerShell and Firefox
  
- `selenium/` - Selenium WebDriver-based scripts
  - More powerful automation capabilities
  - Requires Selenium PowerShell module installation
  
- `workflows/` - Workflow configuration files
  - JSON workflow definitions for common tasks
  - Works with Selenium-based scripts
  
- `archive/` - Historical versions and legacy scripts
  - Older implementations kept for reference
  - Not actively maintained

## Features

### FoxProxy (CLI)

- Open URLs in new windows or tabs
- Launch private browsing sessions
- Perform searches directly
- Get information about running Firefox instances
- Control existing Firefox instances
- Restart or quit Firefox

### Selenium Scripts

- Automate form filling and login processes
- Interact with page elements (click, input text)
- Execute JavaScript within the page
- Take screenshots
- More complex automation flows

## Quick Start

### FoxProxy (Command-Line Interface)

1. Navigate to the `cli` directory
2. Run commands with the `fox.cmd` wrapper:

```
# Get information about running Firefox instances
fox.cmd -Action info

# Open a URL in a new tab
fox.cmd -Action open -Url "https://example.com" -Tab "tab"

# Perform a Google search
fox.cmd -Action search -Query "firefox automation"

# Open a private browsing window
fox.cmd -Action private -Url "https://example.com"
```

### Selenium-based Automation

1. Install the required Selenium module:

```powershell
Install-Module -Name Selenium -Force
```

2. Run a script from the `selenium` directory:

```powershell
.\send_facebook_message.ps1 -Recipient "username" -Message "Hello!"
```

## Requirements

- Windows operating system
- PowerShell 5.1 or higher
- Firefox browser installed in default location
- Selenium PowerShell module (for Selenium-based scripts only)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

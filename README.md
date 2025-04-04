# Firefox Control Tools

A collection of automation tools for Firefox designed specifically for use with Claude_Desktop & MCP Desktop Commander.

## Overview

Firefox Control Tools was entirely conceived, designed, and implemented through interactions with Claude_Desktop & MCP Desktop Commander. This system represents a practical implementation of Claude-powered automation, enabling seamless browser control with minimal user intervention.

The tools provide multiple approaches to Firefox automation, all designed to be used within the Claude_Desktop & MCP Desktop Commander environment:

1. **FoxProxy (Command-line)**: Lightweight command-line interface developed with guidance from Claude for controlling Firefox using native command-line arguments
2. **Selenium-based Scripts**: More powerful automation using Selenium WebDriver for complex interactions, with code written through Claude collaboration
3. **Workflow System**: JSON-based workflow configurations created via Claude for common automation tasks

## Claude_Desktop & MCP Desktop Commander Integration

These tools were specifically engineered to work within the Claude_Desktop & MCP Desktop Commander environment:

- **Direct Command Execution**: All commands can be issued directly through the Claude interface
- **Script Generation**: Claude can dynamically generate custom PowerShell scripts based on your needs
- **Workflow Creation**: Claude can design and modify workflow JSON files to automate complex tasks
- **Problem Solving**: Claude can troubleshoot and optimize Firefox automation in real-time
- **Seamless Execution**: Execute commands without leaving the Claude interface

## Repository Structure

- `cli/` - Command-line interface tools
  - FoxProxy for simple Firefox control via command line
  - Created through Claude's PowerShell expertise
  
- `selenium/` - Selenium WebDriver-based scripts
  - More powerful automation capabilities written by Claude
  - Designed for execution within the MCP Desktop Commander environment
  
- `workflows/` - Workflow configuration files
  - JSON workflow definitions created through Claude collaboration
  - Optimized for Claude-guided execution
  
- `archive/` - Historical versions and legacy scripts
  - Previous iterations from the Claude collaboration process
  - Development history showing Claude's reasoning and improvements

## Features

### FoxProxy (CLI)

- Open URLs in new windows or tabs directly from Claude_Desktop
- Launch private browsing sessions through Claude commands
- Perform searches using Claude-generated queries
- Get information about running Firefox instances for Claude to analyze
- Control existing Firefox instances through Claude's interface
- Restart or quit Firefox with simple Claude commands

### Selenium Scripts

- Automate form filling and login processes with Claude-generated credentials
- Interact with page elements through Claude's guidance
- Execute JavaScript within the page authored by Claude
- Take screenshots for Claude to analyze
- Complex automation flows orchestrated by Claude

## Quick Start

### Using with Claude_Desktop & MCP Desktop Commander

1. Simply ask Claude to help you control Firefox
2. Claude can execute commands directly or guide you through the process
3. Example prompts:
   - "Open example.com in Firefox"
   - "Create a workflow to automate logging into my email"
   - "Help me take a screenshot of a webpage"
   - "Generate a script to fill out a form automatically"

### FoxProxy (Command-Line Interface)

1. Ask Claude to execute commands with the `fox.cmd` wrapper:

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

1. Have Claude install the required Selenium module:

```powershell
Install-Module -Name Selenium -Force
```

2. Ask Claude to run or modify a script from the `selenium` directory:

```powershell
.\send_facebook_message.ps1 -Recipient "username" -Message "Hello!"
```

## Requirements

- Windows operating system
- Claude_Desktop & MCP Desktop Commander
- PowerShell 5.1 or higher
- Firefox browser installed in default location
- Selenium PowerShell module (for Selenium-based scripts only)

## Development Process

This entire project was conceived, designed, coded, and tested through interactions with Claude_Desktop & MCP Desktop Commander. The development process involved:

1. Initial concept discussions with Claude
2. Claude-generated code for core functionality
3. Iterative improvements based on Claude's suggestions
4. Problem-solving and debugging with Claude's assistance
5. Documentation and example creation guided by Claude

## License

This project is licensed under the MIT License - see the LICENSE file for details.

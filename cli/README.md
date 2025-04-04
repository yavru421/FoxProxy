# FoxProxy - Firefox Command Line Interface

A lightweight command-line tool for controlling Firefox browser instances using Firefox's native command-line arguments.

## Features

- Control Firefox without complex dependencies
- Works with existing Firefox installations
- Simple, intuitive command structure
- No need for browser drivers or WebDriver

## Usage

FoxProxy provides several actions to control Firefox from the command line:

### Basic Syntax

```
fox.cmd -Action <action> [parameters]
```

### Available Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `info` | Display information about running Firefox | None |
| `open` | Open a URL in Firefox | `-Url "https://example.com"` <br> `-Tab "current/new/tab"` |
| `search` | Perform a search | `-Query "search terms"` <br> `-Tab "current/new/tab"` |
| `reload` | Reload Firefox | None |
| `private` | Open a private browsing window | `-Url "https://example.com"` (optional) |
| `quit` | Terminate Firefox | None |
| `restart` | Restart Firefox | None |

### Examples

#### Get Firefox Info
```
fox.cmd -Action info
```

#### Open URL in New Tab
```
fox.cmd -Action open -Url "https://example.com" -Tab "tab"
```

#### Open URL in New Window
```
fox.cmd -Action open -Url "https://example.com" -Tab "new"
```

#### Perform Google Search
```
fox.cmd -Action search -Query "firefox automation"
```

#### Open Private Window
```
fox.cmd -Action private -Url "https://example.com"
```

## Requirements

- Windows operating system
- Firefox browser installed in default location
- PowerShell 5.1 or higher

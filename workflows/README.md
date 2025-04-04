# Firefox Automation Workflows

JSON-based workflow definitions for common Firefox automation tasks.

## Overview

Workflows provide a structured way to define automation sequences without writing code. These JSON files can be processed by automation scripts to perform complex tasks like form filling, login procedures, and more.

## Workflow Format

Workflows are defined in JSON format with the following structure:

```json
{
  "name": "Workflow Name",
  "description": "What the workflow does",
  "steps": [
    {
      "instruction": "Human-readable instruction",
      "url": "https://example.com/page",
      "selector": "CSS or XPath selector",
      "selectorType": "css",
      "message": "Element description",
      "waitForClick": true,
      "required": true,
      "delay": 2
    },
    // More steps...
  ]
}
```

### Step Properties

| Property | Description | Required |
|----------|-------------|----------|
| `instruction` | Human-readable description of the step | Yes |
| `url` | URL to navigate to (only for first step usually) | No |
| `selector` | CSS or XPath selector to find an element | No |
| `selectorType` | Selector type: "css" or "xpath" | If selector is provided |
| `message` | Tooltip message for the element | No |
| `waitForClick` | Whether to wait for user to click the element | No (default: false) |
| `required` | Whether the step is required or can be skipped | No (default: false) |
| `delay` | Delay in seconds after completing the step | No (default: 0) |

## Available Workflows

### login-workflow.json

A generic workflow for logging into websites.

### sample-workflow.json

A sample workflow template to demonstrate the format.

## Creating Your Own Workflows

1. Use the existing workflows as templates
2. Test your selectors in browser developer tools
3. Keep steps modular and focused on single actions
4. Include appropriate delays between steps
5. Mark critical steps as required

## Using Workflows

These workflows can be processed by Selenium scripts in the project. In the future, a dedicated workflow processor may be created to standardize the execution.

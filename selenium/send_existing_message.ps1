
param (
    [Parameter(Mandatory=$true)]
    [string]$Recipient,
    
    [Parameter(Mandatory=$true)]
    [string]$Message
)

# Import Selenium module
Import-Module Selenium

# Connect to existing Firefox session
$driver = Get-SeDriver

# Navigate to Facebook Messenger thread
Enter-SeUrl -Driver $driver -Url "https://www.facebook.com/messages/t/$Recipient"

# Script to send the message
$sendMessageScript = @"
(function() {
    // Find message input field
    const messageInput = document.querySelector('div[role="textbox"]');
    
    if (messageInput) {
        // Set the message
        messageInput.focus();
        messageInput.innerHTML = `$Message`;
        
        // Trigger send (simulating Enter key press)
        const event = new KeyboardEvent('keydown', {
            key: 'Enter',
            bubbles: true,
            cancelable: true
        });
        messageInput.dispatchEvent(event);
        
        return true;
    }
    return false;
})();
"@

# Attempt to send message
$messageSent = Invoke-SeJavaScript -Driver $driver -Script $sendMessageScript

# Provide feedback
if ($messageSent) {
    Write-Host "Message sent successfully to $Recipient" -ForegroundColor Green
} else {
    Write-Host "Failed to send message. Please check the message input field." -ForegroundColor Red
}

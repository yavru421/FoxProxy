
param (
    [Parameter(Mandatory=$true)]
    [string]$Recipient,
    
    [Parameter(Mandatory=$true)]
    [string]$Message
)

# Import Selenium module
Import-Module Selenium

# Initialize Firefox
$driver = Start-SeFirefox

# Navigate to Facebook Messenger
Enter-SeUrl -Driver $driver -Url "https://www.facebook.com/messages/t/$Recipient"

# Add a guidance overlay to help you log in
$guidanceScript = @"
(function() {
    const overlay = document.createElement('div');
    overlay.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        background: black;
        color: white;
        padding: 20px;
        text-align: center;
        z-index: 9999;
    `;
    overlay.innerHTML = `
        <h2>Please Complete Login</h2>
        <p>Log into Facebook and navigate to the correct message thread.</p>
        <p>Once logged in and on the right conversation, press SPACE to continue.</p>
    `;
    document.body.appendChild(overlay);

    return new Promise((resolve) => {
        const keyHandler = (e) => {
            if (e.key === ' ') {
                document.removeEventListener('keydown', keyHandler);
                overlay.remove();
                resolve(true);
            }
        };
        document.addEventListener('keydown', keyHandler);
    });
})();
"@

# Wait for user login and thread selection
Invoke-SeJavaScript -Driver $driver -AsyncScript $guidanceScript

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

# Optional: Keep browser open to verify
Write-Host "Press Enter to close the browser..." -ForegroundColor Cyan
Read-Host

# Close browser
Stop-SeDriver -Driver $driver

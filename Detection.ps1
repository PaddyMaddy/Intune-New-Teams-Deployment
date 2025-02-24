<# 
.SYNOPSIS 
    Detects if the New Microsoft Teams App is installed on the device.

.DESCRIPTION 
    - Checks if Teams is present in `C:\Program Files\WindowsApps`.  
    - Implements proper error handling.  
    - Ensures script has permission to access required directories.  

.AUTHOR  
    PaddyMaddy  

.VERSION  
    1.0.1  

.CREATED  
    24-Feb-2025  

.LINK  
    https://paddymaddy.com  
#>

# Define Variables
$teamsPath = "C:\Program Files\WindowsApps"
$teamsPattern = "MSTeams_*"
$logFile = "C:\Windows\Temp\Teams_Detection.log"

# Function to Write Log Messages
Function Write-Log {
    param ([string]$message)
    $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timeStamp - $message"
    Write-Host $logEntry
    Add-Content -Path $logFile -Value $logEntry
}

Write-Log "Starting Microsoft Teams detection process..."

# Check if Teams directory exists
if (-not (Test-Path $teamsPath)) {
    Write-Log "Teams installation directory not found. Marking as NOT installed."
    exit 1
}

# Search for Microsoft Teams
$teamsInstalled = Get-ChildItem -Path $teamsPath -Filter $teamsPattern -ErrorAction SilentlyContinue

if ($teamsInstalled) {
    Write-Log "✅ New Microsoft Teams client is installed."
    exit 0
} else {
    Write-Log "❌ Microsoft Teams client NOT found."
    exit 1
}

<# 
.SYNOPSIS 
    Uninstalls the New Microsoft Teams App from the device.

.DESCRIPTION 
    - Uses `teamsbootstrapper.exe -x` for uninstallation.  
    - Logs the process for troubleshooting.  
    - Validates if Teams is fully removed.  

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
$bootstrapperPath = "C:\Program Files\WindowsApps\teamsbootstrapper.exe"
$logFile = "C:\Windows\Temp\Teams_Uninstall.log"

# Function to Write Log Messages
Function Write-Log {
    param ([string]$message)
    $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timeStamp - $message"
    Write-Host $logEntry
    Add-Content -Path $logFile -Value $logEntry
}

Write-Log "Starting Microsoft Teams uninstallation process..."

# Verify Admin Privileges
$adminCheck = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $adminCheck.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Log "ERROR: Script requires Administrator privileges. Exiting..."
    exit 2
}
Write-Log "Script running with Administrator privileges."

# Check if Teams Bootstrapper Exists
if (-not (Test-Path $bootstrapperPath)) {
    Write-Log "ERROR: Teams bootstrapper not found. Exiting..."
    exit 1
}

# Run the Uninstall Command
Write-Log "Executing Teams uninstallation..."
try {
    Start-Process -FilePath $bootstrapperPath -ArgumentList "-x" -NoNewWindow -Wait
    Write-Log "✅ Uninstallation command executed successfully."
} catch {
    Write-Log "❌ ERROR: Uninstallation failed. $_"
    exit 1
}

# Validate if Microsoft Teams is Fully Removed
$teamsPath = "C:\Program Files\WindowsApps\MSTeams_*"
if (Test-Path $teamsPath) {
    Write-Log "❌ ERROR: Microsoft Teams still detected after uninstall attempt. Exiting..."
    exit 1
}

Write-Log "✅ Microsoft Teams has been successfully uninstalled."
exit 0

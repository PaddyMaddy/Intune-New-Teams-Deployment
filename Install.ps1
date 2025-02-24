<# 
.SYNOPSIS 
    Installs the New Microsoft Teams App on the target device.

.DESCRIPTION 
    - Copies the MSIX file to Temp.  
    - Executes `teamsbootstrapper.exe` for installation.  
    - Ensures installation is successful.  

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
$msixFile = ".\MSTeams-x64.msix"
$destinationPath = "C:\Windows\Temp"
$bootstrapperPath = ".\teamsbootstrapper.exe"
$logFile = "$destinationPath\Teams_Install.log"

# Function to Write Log Messages
Function Write-Log {
    param ([string]$message)
    $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timeStamp - $message"
    Write-Host $logEntry
    Add-Content -Path $logFile -Value $logEntry
}

Write-Log "Starting Microsoft Teams installation process..."

# Verify Admin Privileges
$adminCheck = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $adminCheck.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Log "ERROR: Script requires Administrator privileges. Exiting..."
    exit 2
}
Write-Log "Script running with Administrator privileges."

# Check if MSIX file exists
if (-not (Test-Path $msixFile)) {
    Write-Log "ERROR: MSTeams-x64.msix file not found. Exiting..."
    exit 1
}

# Copy MSIX file to Temp
Write-Log "Copying MSIX file to $destinationPath..."
Copy-Item -Path $msixFile -Destination $destinationPath -Force -ErrorAction Stop

# Check if Bootstrapper exists
if (-not (Test-Path $bootstrapperPath)) {
    Write-Log "ERROR: teamsbootstrapper.exe not found. Exiting..."
    exit 1
}

# Install Teams
Write-Log "Executing Teams installation..."
try {
    Start-Process -FilePath $bootstrapperPath -ArgumentList "-p", "-o", "$destinationPath\MSTeams-x64.msix" -Wait -WindowStyle Hidden
    Write-Log "✅ Microsoft Teams installation completed successfully."
    exit 0
} catch {
    Write-Log "❌ ERROR: Installation failed. $_"
    exit 1
}

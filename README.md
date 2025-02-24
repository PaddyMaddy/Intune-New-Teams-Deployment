📌 Intune-New-Teams-Deployment
This repository contains PowerShell scripts to help deploy, detect, and uninstall the New Microsoft Teams application using Microsoft Intune.

📂 Repository Contents
Install.ps1 - Installs the New Microsoft Teams application.
Detection.ps1 - Checks if the New Microsoft Teams is installed.
Uninstall.ps1 - Uninstalls the New Microsoft Teams application.
LICENSE - License information for this repository.

🛠 Prerequisites
Before proceeding, ensure the following:

You have Microsoft Intune Admin access.
Devices are Azure AD joined or Hybrid Azure AD joined and enrolled in Intune.
Devices meet the system requirements for the New Microsoft Teams.
You have Global Admin or Intune Administrator privileges in Microsoft Endpoint Manager.

🚀 Deployment Steps
1️⃣ Uploading Install.ps1 to Microsoft Intune
Log in to Microsoft Intune Admin Center:
➝ https://intune.microsoft.com

Navigate to Apps ➝ Windows ➝ Add.

Select Win32 app and upload the New Microsoft Teams installer (.intunewin) package.

Under Program, set the following:
Install command
%SystemRoot%\sysnative\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0install.ps1"

Uninstall command:
%SystemRoot%\sysnative\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0uninstall.ps1"

Run as: System
Click Next ➝ Configure Detection Rules.


2️⃣ Configuring Detection.ps1 as a Custom Detection Rule
Under Detection rules, choose Custom script.
Upload Detection.ps1.
Set Run script as 64-bit process on 64-bit clients to Yes.
Click Next ➝ Assign the app to users or devices.
Click Create.

3️⃣ Uninstalling the New Microsoft Teams using Uninstall.ps1
If you need to remove the New Microsoft Teams from devices:
Navigate to Apps ➝ Windows ➝ Find the deployed Teams app.
Click Properties ➝ Scroll to Uninstall command.
Click Edit and confirm the following command is set:
%SystemRoot%\sysnative\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0uninstall.ps1"
Click Save and apply the changes.
You can also deploy Uninstall.ps1 via Intune Scripts if needed.

📊 Monitoring Deployment Status
To check deployment results:

Go to Intune Admin Center ➝ Devices ➝ Monitor.
Select Scripts ➝ Find Install.ps1, Detection.ps1, or Uninstall.ps1 deployment status.
View Success, Pending, or Failed devices.
For application deployment status:

Go to Apps ➝ Windows ➝ Select your Teams deployment.
Under Monitor, review installation reports.

🔗 References
Microsoft Docs: Deploying Teams with Intune -> https://learn.microsoft.com/en-us/microsoftteams/
Microsoft Intune Script Deployment Guide -> https://learn.microsoft.com/en-us/mem/intune/apps/intune-management-extension

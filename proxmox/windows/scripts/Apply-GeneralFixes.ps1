# Show file extensions in explorer
reg.exe ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ /v HideFileExt /t REG_DWORD /d 0 /f

# Enable QuickEdit mode
reg.exe ADD HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f

# Show run command in Start menu
reg.exe ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ /v Start_ShowRun /t REG_DWORD /d 1 /f

# Show administrative tools in Start menu
reg.exe ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ /v StartMenuAdminTools /t REG_DWORD /d 1 /f

# Zero hibernation file
reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateFileSizePercent /t REG_DWORD /d 0 /f

# Disable hibernation mode
reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateEnabled /t REG_DWORD /d 0 /f

# Automatically rearm Windows Evaluation
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "(Get-WmiObject SoftwarelicensingService).ReArmWindows()"
$trigger = New-ScheduledTaskTrigger -Daily -At "12:00 PM"
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet
Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -Settings $settings -TaskName "Rearm Windows" -Description "Rearm Windows"

# Get help files for cmdlets
Update-Help -Force -ErrorAction SilentlyContinue

# Automatically rearm Windows Evaluation
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "(Get-WmiObject SoftwarelicensingService).ReArmWindows()"
$trigger = New-ScheduledTaskTrigger -Daily -At "12:00 PM"
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet
Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -Settings $settings -TaskName "Rearm Windows" -Description "Rearm Windows"
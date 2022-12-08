reg.exe load HKEY_USERS\TempHive "C:\Users\Default\NTUSER.DAT"

TASKKILL /IM explorer.exe /F

Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'ShowTaskViewButton' -Type 'DWord' -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name 'SearchboxTaskbarMode' -Type 'DWord' -Value 0

Start-Process explorer.exe
# Allow Remote Desktop in Firewall
Set-NetFirewallRule -DisplayGroup "Remote Desktop" -Enabled True

# Enable Remote Desktop in Registry
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0 -Force

# Disable NLA
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -ComputerName $(hostname) -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0)

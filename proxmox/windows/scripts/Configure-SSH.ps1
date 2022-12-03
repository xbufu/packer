Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# Disable single admin authorized keys
# Write-Host "Updating sshd_config"

$sshdConfig = @"
 
ListenAddress 0.0.0.0
Port 22
 
Protocol 2 # disable legacy support for security reasons
StrictModes yes # make sure sshd checks file modes and ownership before accepting logins
UsePrivilegeSeparation sandbox
Compression no
UseDNS no
 
# TCP keep alive messages are spoofable, use client keep alive instead
TCPKeepAlive no
ClientAliveInterval 300
ClientAliveCountMax 3
 
AuthorizedKeysFile .ssh/authorized_keys
PubkeyAuthentication yes
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
 
Ciphers aes256-gcm@openssh.com,aes256-ctr,chacha20-poly1305@openssh.com
KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
MACs hmac-sha2-256,hmac-sha2-512
 
# never use host-based auth
IgnoreRhosts yes
IgnoreUserKnownHosts yes
HostbasedAuthentication no
RhostsRSAAuthentication no
 
X11Forwarding no
X11UseLocalhost yes
PermitUserEnvironment yes
AcceptEnv LANG LC_*
 
# Enable debug logging
# Prior to launching, let's enable debug logging for SSH.
# To view SSH logs, run this on the machine from a terminal:
# Get-Content -Path C:\ProgramData\ssh\Logs\sshd.log -Wait -Tail 0
SyslogFacility LOCAL0
LogLevel DEBUG3
 
"@

# Set-Content "$env:PROGRAMDATA\ssh\sshd_config" $sshdConfig

# Add authorized key
$authorizedKey = 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQIR1skomUNRz8ezrJrdyefNoE9mL4s0jaoKg0yinuI colin@framework'
Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value $authorizedKey
icacls.exe ""$env:ProgramData\ssh\administrators_authorized_keys"" /inheritance:r /grant ""Administrators:F"" /grant ""SYSTEM:F""

# Restart Start SSH
Write-Host "Restarting SSH"
Restart-Service sshd
Write-Host "Done"

# Set PowerShell as the default shell for SSH.
$PSCommand = Get-Command "powershell.exe"
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value $PSCommand.source -PropertyType String -Force
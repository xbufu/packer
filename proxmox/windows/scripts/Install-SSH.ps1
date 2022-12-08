if(! (Test-Path -Path "$env:PROFILE\.installed_ssh")) {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    
    $repo = "PowerShell/Win32-OpenSSH"
    $filenamePattern = "OpenSSH-Win64-*.msi"
        
    Write-Host "Getting latest release"
    $releases = "https://api.github.com/repos/$repo/releases/latest"
    $release = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].assets | Where-Object Name -Like $filenamePattern
        
    $url = $release.browser_download_url
    $filename = $release.name
    $file = "$env:TEMP\$filename"
        
    Write-Host "Downloading $filename"
    Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\$filename"
        
    Write-Host "Installing OpenSSH"
    Start-Process -Wait -NoNewWindow -FilePath msiexec.exe -ArgumentList "/qb /i $file"

    Write-Host "Adding C:\Program Files\OpenSSH to PATH"
    setx PATH "$env:PATH;C:\Program Files\OpenSSH" -m

    New-Item -Path "$env:PROFILE\.installed_ssh" -Force
} else {
    Write-Host "Setting PowerShell as the default shell"
    New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
        
    Write-Host "Editing sshd_config"
    $sshd_config = Get-Content "$env:ProgramData\ssh\sshd_config"
    $sshd_config = $sshd_config -replace '#StrictModes yes', 'StrictModes no'
    $sshd_config = $sshd_config -replace '#PasswordAuthentication yes', 'PasswordAuthentication yes'
    $sshd_config = $sshd_config -replace '#PubkeyAuthentication yes', 'PubkeyAuthentication yes'
    $sshd_config = $sshd_config -replace '#PermitUserEnvironment no', 'PermitUserEnvironment yes'
    $sshd_config = $sshd_config -replace '#PermitRootLogin prohibit-password', 'PermitRootLogin yes'
    Set-Content "$env:ProgramData\ssh\sshd_config" $sshd_config
        
    Write-Host "Adding public key"
    $publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQIR1skomUNRz8ezrJrdyefNoE9mL4s0jaoKg0yinuI colin@framework"
    Add-Content "$env:ProgramData\ssh\administrators_authorized_keys" -Value $publicKey -Force
    icacls.exe "$env:ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"

    Write-Host "Restarting sshd"
    Restart-Service sshd

    Remove-Item -Path "$env:PROFILE\.installed_ssh" -Force
}

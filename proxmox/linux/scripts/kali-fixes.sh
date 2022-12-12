#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export SILENT=">/dev/null 2>&1"
# export SILENT="2>&1"

# Fix power settings
echo "Fixing power settings..."
eval mkdir -p /root/.config/xfce4/xfconf/xfce-perchannel-xml
eval wget https://raw.githubusercontent.com/Dewalt-arch/pimpmyi3-config/main/xfce4/xfce4-power-manager.xml -O /root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml $SILENT

# Silence PC beep
echo "Silencing PC beep..."
eval mkdir -p /etc/modprobe.d
echo -e "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf $SILENT

# Fix nmap scripts
echo "Fixing nmap scripts..."
eval mkdir -p /usr/share/nmap/scripts $SILENT
rm -f /usr/share/nmap/scripts/clamav-exec.nse
eval wget https://raw.githubusercontent.com/nmap/nmap/master/scripts/clamav-exec.nse -O /usr/share/nmap/scripts/clamav-exec.nse $SILENT

# Unzip rockyou
echo "Extracting rockyou.txt..."
if [ -f /usr/share/wordlists/rockyou.txt.gz ]
then
    eval gzip -dq /usr/share/wordlists/rockyou.txt.gz $SILENT
fi

# Fix minimum SMB protocol
echo "Downgrading minimum SMB protocol version..."
check_min=$(cat /etc/samba/smb.conf | grep -c -i "client min protocol")
check_max=$(cat /etc/samba/smb.conf | grep -c -i "client max protocol")

if [ $check_min -ne 0 ] || [ $check_max -ne 0 ]
then
    echo -n ""
else
    sed 's/\[global\]/\[global\]\n   client min protocol = CORE\n   client max protocol = SMB3\n''/' -i /etc/samba/smb.conf
fi

# Enable postgresql
echo "Enabling postgresql..."
eval systemctl enable --now postgresql $SILENT

# Initialize msfdb
echo "Initializing Metasploit database..."
eval msfdb init $SILENT

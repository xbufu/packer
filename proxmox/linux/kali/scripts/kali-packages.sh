#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export SILENT=">/dev/null 2>&1"
# export SILENT="2>&1"

essential=$(cat <<EOF
autogen
automake
apache2
build-essential
cifs-utils
curl
dkms
eog
exploitdb
flameshot
gcc-multilib
gcc-mingw-w64-x86-64-win32
gdb
gimp
git
gnupg
golang
gparted
htop
openjdk-17-jdk
openjdk-17-jre
openjdk-17-dbg
openjdk-17-doc
libffi-dev
libguestfs-tools
libmpc-dev
libssl-dev
linux-headers-$(uname -r)
manpages-dev
manpages-posix-dev
masscan
mlocate
nano
nasm
nmap
neovim
openssl
proxychains
python2
python2-dev
python3-argcomplete
python3-dev
python3-distutils
python3-setuptools
python3-venv
rdesktop
seclists
socat
sqlite3
sqlitebrowser
tmux
vim
wget
whatweb
wireshark
xclip
xpdf
xxd
freerdp2-x11
EOF
)

additional=$(cat <<EOF
amass
binwalk
bloodhound
bloodhound.py
burpsuite
certipy-ad
cewl
crunch
dnsenum
dnsrecon
dos2unix
enum4linux
exe2hexbat
exiftool
ffuf
ghex
ghidra
gpp-decrypt
hashcat
hashcat-utils
hydra
impacket-scripts
john
laudanum
macchanger
maltego
maltego-teeth
metasploit-framework
mimikatz
nbtscan
netdiscover
ngrep
nikto
onesixtyone
oscanner
passing-the-hash
peass
powershell-empire
python3-impacket
python3-ldapdomaindump
recon-ng
responder
samdump2
smbclient
smbmap
smtp-user-enum
snmpcheck
sqlmap
ssldump
sslscan
sslsplit
sslyze
starkiller
steghide
thc-ipv6
webshells
windows-binaries
winexe
wkhtmltopdf
wordlists
wpscan
EOF
)

echo "Updating repositories..."
eval apt update $SILENT

echo "Installing essential packages..."
eval apt install -y $(echo $essential | tr '\n' ' ') $SILENT

echo "Installing additional packages..."
eval apt install -y $(echo $additional | tr '\n' ' ') $SILENT

#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export SILENT=">/dev/null 2>&1"
# export SILENT="2>&1"

echo "Installing xrdp..."
eval apt install xorg xrdp -y $SILENT

echo "Downgrading encryption for better performance..."
sed -i 's/crypt_level=high/crypt_level=none/g' /etc/xrdp/xrdp.ini

echo "Enabling the xrdp service..."
eval systemctl enable xrdp $SILENT
eval systemctl restart xrdp $SILENT

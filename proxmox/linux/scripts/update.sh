#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export SILENT=">/dev/null 2>&1"
# export SILENT="2>&1"

# Update the system
echo "Updating the system..."
eval apt update $SILENT
eval apt dist-upgrade -y $SILENT
eval apt autoclean -y $SILENT
eval apt autoremove -y $SILENT

echo "Updating filesystem cache..."
eval updatedb $SILENT
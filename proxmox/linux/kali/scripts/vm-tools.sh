#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export SILENT=">/dev/null 2>&1"
# export SILENT="2>&1"

# VM tools
eval apt install -y open-vm-tools open-vm-tools-desktop fuse3 $SILENT
eval systemctl enable --now open-vm-tools $SILENT

# QEMU guest agent
eval apt install -y qemu-guest-agent $SILENT

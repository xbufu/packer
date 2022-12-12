#!/bin/bash

echo "Setting up dotfiles..."

echo "Installing chezmoi..."
$(exec 1>/dev/null 2>/dev/null; sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin)

echo "Applying dotfiles..."
chezmoi init --apply --force https://github.com/xbufu/dotfiles.git 

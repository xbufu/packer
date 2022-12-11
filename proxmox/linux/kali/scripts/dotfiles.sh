#!/bin/bash

echo "Setting up dotfiles..."

echo "Installing chezmoi..."
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

echo "Applying dotfiles..."
chezmoi init --apply --force https://github.com/xbufu/dotfiles.git

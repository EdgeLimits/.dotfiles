#!/bin/bash

if ! command -v stow &>/dev/null; then
  echo "Install stow first"
  exit 1
fi

rm -f ~/.bashrc
rm -rf ~/.config/starship.toml
# rm -rf ~/.config/alacritty
rm -rf ~/.config/ghostty
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.config/waybar
rm -f ~/.config/hypr/bindings.conf

stow zsh
stow bash
stow starship
stow vimrc
# stow alacritty
stow ghostty
stow nvim
stow waybar
stow hypr

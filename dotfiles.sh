#!/bin/bash


if ! command -v stow &>/dev/null; then
  echo "Install stow first"
  exit 1
fi


rm -rf ~/.config/starship.toml
rm -rf ~/.config/alacritty
rm -rf ~/.config/ghostty

stow zsh
stow starship
stow vimrc
stow alacritty
stow ghostty

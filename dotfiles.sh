#!/bin/bash

if ! command -v stow &>/dev/null; then
  echo "Install stow first"
  exit 1
fi

rm -f ~/.bashrc
rm -rf ~/.config/starship.toml
rm -rf ~/.config/ghostty
rm -f ~/.config/xdg-terminals.list
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim

# Omarchy 4 ships these as real files in ~/.config/hypr; they are the designated
# user-override files, so we replace them with our own. `omarchy refresh
# hyprland` will put Omarchy's versions back -- writing through the symlinks
# into this repo, where git can recover them.
rm -f ~/.config/hypr/{monitors,input,looknfeel,bindings,autostart}.lua

stow zsh
stow bash
stow starship
stow vimrc
stow ghostty
stow nvim
stow hypr

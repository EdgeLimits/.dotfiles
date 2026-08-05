#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STYLES_DIR="$DOTFILES_DIR/mako/styles"
MAKO_SCRIPT="$DOTFILES_DIR/mako/bin/mako-style-set"

# Symlink mako-style-set to PATH
ln -sf "$MAKO_SCRIPT" "$HOME/.local/bin/mako-style-set"
echo "mako-style-set linked to ~/.local/bin"

# Set default style if current.ini symlink is missing or broken
# (e.g. a stale absolute-path target committed from another machine/user)
if [ ! -L "$STYLES_DIR/current.ini" ] || [ ! -e "$STYLES_DIR/current.ini" ]; then
    ln -sf "rounded.ini" "$STYLES_DIR/current.ini"
    echo "Mako style set to: rounded"
fi

# The actual wiring into Omarchy's per-theme mako.ini is the stowed
# mako/.config/omarchy/themed/mako.ini.tpl override template — Omarchy's
# template engine checks ~/.config/omarchy/themed/ before its own built-in
# templates, so this style survives `omarchy theme set` across all themes.
echo "Mako style setup complete!"

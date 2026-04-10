#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STYLES_DIR="$DOTFILES_DIR/mako/styles"
MAKO_SCRIPT="$DOTFILES_DIR/mako/bin/mako-style-set"
MAKO_CONFIG="$HOME/.config/mako/config"
INCLUDE_LINE="include=~/.dotfiles/mako/styles/current.ini"

# Symlink mako-style-set to PATH
ln -sf "$MAKO_SCRIPT" "$HOME/.local/bin/mako-style-set"
echo "mako-style-set linked to ~/.local/bin"

# Set default style if no current.ini symlink exists
if [ ! -L "$STYLES_DIR/current.ini" ]; then
    ln -sf "$STYLES_DIR/default.ini" "$STYLES_DIR/current.ini"
    echo "Mako style set to: default"
fi

# Add include line to mako config if not already present
if [ -f "$MAKO_CONFIG" ]; then
    if ! grep -Fq "$INCLUDE_LINE" "$MAKO_CONFIG"; then
        sed -i "s|^include=~/.local/share/omarchy/default/mako/core.ini|include=~/.local/share/omarchy/default/mako/core.ini\n$INCLUDE_LINE|" "$MAKO_CONFIG"
        echo "Mako style include added to $MAKO_CONFIG"
    else
        echo "Mako style include already present in $MAKO_CONFIG"
    fi
else
    echo "Warning: $MAKO_CONFIG not found — skipping include injection (run after omarchy is set up)"
fi

echo "Mako style setup complete!"

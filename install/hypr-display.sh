#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="$DOTFILES_DIR/hypr/bin"

mkdir -p "$HOME/.local/bin"

for script in edge-display-sleep edge-display-wake edge-display-lock edge-hypridle-supervise; do
  ln -sf "$BIN_DIR/$script" "$HOME/.local/bin/$script"
  echo "$script linked to ~/.local/bin"
done

# Restart policy for hypridle. See the drop-in for why.
mkdir -p "$HOME/.config/systemd/user/hypridle.service.d"
systemctl --user daemon-reload

echo
echo "Wired up. Remaining manual bits already in the repo:"
echo "  - ~/.config/hypr/hypridle.conf      calls edge-display-lock / edge-display-wake"
echo "  - ~/.config/hypr/autostart.conf     exec-once = edge-hypridle-supervise"
echo "  - hyprland/hyprland-overrides.conf  SUPER SHIFT U -> edge-display-wake"

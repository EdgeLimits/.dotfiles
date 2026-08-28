-- Displays and workspace pinning.
-- Ported from hyprland/hyprland-overrides.conf during the Omarchy 4 migration.
--
-- List monitors and supported modes with: hyprctl monitors all
--
-- NOTE: `omarchy refresh hyprland` overwrites every hypr/*.lua with Omarchy's
-- defaults. These files are stow symlinks, so that writes into ~/.dotfiles.
-- Recover with git if it ever happens.

-- Xwayland has a single global scale, so this is matched to the primary panel.
hl.env("GDK_SCALE", "1.5")

-- Office / Healper station
hl.monitor({ output = "eDP-1", mode = "2880x1800@120", position = "0x0", scale = 1.5 }) -- TUXEDO panel
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x-1080", scale = 1 }) -- HDMI behind TUXEDO
hl.monitor({ output = "DP-1", mode = "2560x1440@60", position = "auto", scale = 1 }) -- USB-C behind TUXEDO
hl.monitor({ output = "DP-3", mode = "1920x1080@60", position = "auto", scale = 1 }) -- HDMI behind TUXEDO

-- Anything else: let Hyprland decide.
-- Catch-all for anything not listed above.
--
-- Deliberately NOT written as
--   hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-- omarchy-hyprland-monitor-scaling (SUPER+/ and SUPER+ALT+/) sed -i's that
-- exact line plus the GDK_SCALE above it, to persist a scale change -- but only
-- when it thinks monitors.lua is still Omarchy's untouched default. sed -i
-- replaces the file, which breaks the stow symlink and silently diverges this
-- repo from ~/.config. Reordering the keys is semantically identical and makes
-- the guard treat this file as customized, which it is.
hl.monitor({ mode = "preferred", output = "", position = "auto", scale = 1 })

-- Home station (kept for reference)
-- hl.monitor({ output = "DP-3", mode = "3840x2160@120", position = "0x0", scale = 1.5 })
-- hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@60", position = "2560x-800", scale = 1, transform = 1 })

-- Workspace pinning (Healper layout)
hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })

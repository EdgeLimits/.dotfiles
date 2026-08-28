-- Displays, scaling and workspace pinning, per machine.
--
-- List a machine's outputs and supported modes with: hyprctl monitors all
--
-- NOTE: `omarchy refresh hyprland` overwrites every hypr/*.lua with Omarchy's
-- defaults. These files are stow symlinks, so that writes into ~/.dotfiles.
-- Recover with git if it ever happens.

local function hostname()
	local f = io.open("/etc/hostname", "r")
	if not f then
		return nil
	end
	local name = f:read("l")
	f:close()
	return name ~= "" and name or nil
end

-- Per-machine hardware.
--
-- A machine that is not listed still comes up correctly: the catch-all at the
-- bottom brings every display up at its preferred mode, and no workspace
-- pinning is applied. Adding an entry here is an optimisation, not a
-- requirement.
local hosts = {
	edge = {
		-- GTK reads GDK_SCALE as an integer, so this is the panel's scale
		-- rounded to the nearest whole number -- what Omarchy itself does
		-- (int(scale + 0.5)) and what it ships for this panel. The pre-Quattro
		-- config had 1.5 here, which GTK cannot use.
		gdk_scale = 2,

		monitors = {
			-- Office dock
			{ output = "eDP-1", mode = "2880x1800@120", position = "0x0", scale = 1.5 }, -- TUXEDO panel
			{ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x-1080", scale = 1 }, -- HDMI behind TUXEDO
			{ output = "DP-1", mode = "2560x1440@60", position = "auto", scale = 1 }, -- USB-C behind TUXEDO
			{ output = "DP-3", mode = "1920x1080@60", position = "auto", scale = 1 }, -- HDMI behind TUXEDO

			-- Home dock, kept for reference. This is the same laptop in a
			-- different dock, so the hostname cannot tell the two apart --
			-- swap these in by hand when the layout changes.
			-- { output = "DP-3", mode = "3840x2160@120", position = "0x0", scale = 1.5 },
			-- { output = "HDMI-A-1", mode = "2560x1440@60", position = "2560x-800", scale = 1, transform = 1 },
		},

		-- Unlisted or disconnected monitors fall back to whatever display is
		-- available, so these are safe to leave in place while undocked.
		workspaces = {
			{ workspace = "1", monitor = "eDP-1" },
			{ workspace = "2", monitor = "eDP-1" },
			{ workspace = "3", monitor = "DP-1" },
			{ workspace = "4", monitor = "DP-1" },
			{ workspace = "5", monitor = "DP-1" },
		},
	},

	-- Second machine: copy the block above, set the hostname as the key, and
	-- fill in from `hyprctl monitors all`. Until then it uses the catch-all.
	--
	-- ["other-host"] = {
	-- 	gdk_scale = 1,
	-- 	monitors = {
	-- 		{ output = "DP-1", mode = "2560x1440@144", position = "0x0", scale = 1 },
	-- 		{ output = "DP-2", mode = "2560x1440@144", position = "2560x0", scale = 1 },
	-- 	},
	-- 	workspaces = {
	-- 		{ workspace = "1", monitor = "DP-1" },
	-- 		{ workspace = "2", monitor = "DP-2" },
	-- 	},
	-- },
}

local host = hosts[hostname() or ""] or {}

-- 1 is the safe default: no scaling on hardware we know nothing about.
hl.env("GDK_SCALE", tostring(host.gdk_scale or 1))

for _, monitor in ipairs(host.monitors or {}) do
	hl.monitor(monitor)
end

for _, workspace in ipairs(host.workspaces or {}) do
	hl.workspace_rule(workspace)
end

-- Catch-all for anything not matched above. Must come last.
--
-- Deliberately NOT written as
--   hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-- omarchy-hyprland-monitor-scaling (SUPER+/ and SUPER+ALT+/) sed -i's that
-- exact line plus a GDK_SCALE line, to persist a scale change -- but only when
-- it thinks monitors.lua is still Omarchy's untouched default. sed -i replaces
-- the file, which breaks the stow symlink and silently diverges this repo from
-- ~/.config. Reordering the keys is semantically identical and makes the guard
-- treat this file as customised, which it is.
hl.monitor({ mode = "preferred", output = "", position = "auto", scale = 1 })

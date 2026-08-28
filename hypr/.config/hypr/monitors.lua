-- Displays, scaling and workspace pinning, per machine and per dock.
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

-- Per-machine hardware, with per-dock profiles where one machine sees more
-- than one monitor layout. Hostname can tell machines apart but not docks --
-- switch `profile` by hand when redocking.
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
		-- config had 1.5 here, which GTK cannot use. Both profiles below
		-- round to the same value, so it isn't per-profile.
		gdk_scale = 2,

		-- Same laptop, different docks. Set to whichever is currently
		-- plugged in.
		profile = "home", -- "office" | "home"

		profiles = {
			office = {
				monitors = {
					{ output = "eDP-1", mode = "2880x1800@120", position = "0x0", scale = 1.5 }, -- TUXEDO panel
					{ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x-1080", scale = 1 }, -- HDMI behind TUXEDO
					{ output = "DP-1", mode = "2560x1440@60", position = "auto", scale = 1 }, -- USB-C behind TUXEDO
					{ output = "DP-3", mode = "1920x1080@60", position = "auto", scale = 1 }, -- HDMI behind TUXEDO
				},

				-- Unlisted or disconnected monitors fall back to whatever
				-- display is available, so these are safe to leave in place
				-- while undocked.
				workspaces = {
					{ workspace = "1", monitor = "eDP-1" },
					{ workspace = "2", monitor = "eDP-1" },
					{ workspace = "3", monitor = "DP-1" },
					{ workspace = "4", monitor = "DP-1" },
					{ workspace = "5", monitor = "DP-1" },
				},
			},

			-- Home station: Samsung 4K flat on the left, ASUS rotated
			-- vertical on the right. Restores the pre-Quattro "HOME STATION"
			-- layout (see git history predating the Lua port), values
			-- re-checked against this dock's `hyprctl monitors all`.
			home = {
				monitors = {
					{ output = "DP-3", mode = "3840x2160@120", position = "0x0", scale = 1.5 }, -- Samsung LS28AG700N
					{ output = "HDMI-A-1", mode = "2560x1440@60", position = "2560x-800", scale = 1, transform = 1 }, -- ASUS XG27ACS, portrait
				},

				workspaces = {
					{ workspace = "1", monitor = "DP-3" },
					{ workspace = "2", monitor = "DP-3" },
					{ workspace = "3", monitor = "DP-3" },
					{ workspace = "4", monitor = "HDMI-A-1" },
					{ workspace = "5", monitor = "HDMI-A-1" },
				},
			},
		},
	},

	-- Second machine: copy a profile block above, set the hostname as the
	-- key, and fill in from `hyprctl monitors all`. Until then it uses the
	-- catch-all.
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
local active = (host.profiles or {})[host.profile] or host

-- 1 is the safe default: no scaling on hardware we know nothing about.
hl.env("GDK_SCALE", tostring(host.gdk_scale or 1))

for _, monitor in ipairs(active.monitors or {}) do
	hl.monitor(monitor)
end

for _, workspace in ipairs(active.workspaces or {}) do
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

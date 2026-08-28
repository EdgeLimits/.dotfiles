-- Appearance overrides.
-- Ported from hyprland/hyprland-overrides.conf during the Omarchy 4 migration.

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 16,
		border_size = 0,
	},

	decoration = {
		rounding = 8,
		active_opacity = 2.0,
		inactive_opacity = 0.9,
		dim_inactive = true,
		dim_strength = 0.1,
	},
})

-- Xwayland has one global scale for all monitors, so it cannot natively match
-- both a 1.5x and a 1.0x display at once (hyprwm/Hyprland#6281). Omarchy's
-- xwayland:force_zero_scaling default already makes Hyprland scale Steam's
-- unscaled buffer per-monitor, so sizing is close on both -- this just forces
-- nearest-neighbor filtering so the upscale stays crisp instead of blurry.
o.window("steam", { nearest_neighbor = true })

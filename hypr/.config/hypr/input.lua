-- Keyboard and pointer overrides.
-- Ported from hyprland/hyprland-overrides.conf during the Omarchy 4 migration.

hl.config({
  input = {
    -- US / Latvian / Danish, cycled with Alt+Shift. Right Alt is the level-3
    -- switch so Latvian's third level stays reachable.
    kb_layout = "us,lv,dk",
    kb_variant = ",apostrophe",

    -- Replaces Omarchy's default "compose:caps,shift:both_capslock_cancel".
    -- Append those here if you want Caps-as-Compose back alongside the
    -- layout switcher.
    kb_options = "grp:alt_shift_toggle,lv3:ralt_switch",

    -- Slower repeat onset than Omarchy's 250ms default. Carried over from the
    -- pre-Quattro ~/.config/hypr/input.conf, which the upgrade orphaned.
    repeat_delay = 600,
  },
})

-- Omarchy's defaults already cover repeat_rate 40, numlock_by_default,
-- touchpad scroll_factor 0.4, and the terminal scroll_touchpad rules.
--
-- The pre-Quattro input.conf also had touchpad clickfinger_behavior commented
-- out (Omarchy enables it). Uncomment to go back to corner right-click:
-- hl.config({ input = { touchpad = { clickfinger_behavior = false } } })

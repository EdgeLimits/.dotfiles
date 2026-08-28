-- Keybinding overrides.
-- Ported from hypr/.config/hypr/bindings.conf during the Omarchy 4 migration.
--
-- Omarchy 4 already ships everything the old bindings.conf carried -- the
-- hey.com Calendar/Email URLs, Spotify, cliamp, Signal, Obsidian, 1Password,
-- the webapps, all of it -- in default/hypr/bindings/applications.lua. Only
-- the genuine deviations from those defaults belong here.
--
-- See current bindings: omarchy menu keybindings --print

-- SUPER+SHIFT+A defaults to ChatGPT. Take it for Claude and move ChatGPT over.
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Claude", {
  focus = "^com\\.anthropic\\.Claude$",
  launch = "claude-desktop",
})
o.bind("SUPER + CTRL + SHIFT + A", "ChatGPT", { webapp = "https://chatgpt.com" })

-- SUPER+SHIFT+W defaults to Omawrite. Prefer Typora.
hl.unbind("SUPER + SHIFT + W")
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })

-- macOS-style screenshots. Omarchy 4 renamed omarchy-cmd-screenshot to
-- omarchy-capture-screenshot.
o.bind("SUPER + CTRL + 3", "Screenshot fullscreen to clipboard", "omarchy-capture-screenshot smart clipboard")
o.bind("SUPER + CTRL + 4", "Screenshot area with editing", "omarchy-capture-screenshot")
o.bind("SUPER + CTRL + 5", "Screenshot fullscreen to file", "omarchy-capture-screenshot smart")

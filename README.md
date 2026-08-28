# dotfiles

Personal dotfiles for an [Omarchy](https://omarchy.org/) (Hyprland) machine,
managed with [GNU Stow](https://www.gnu.org/software/stow/). Currently used
across three environments (see [Multiple docks / machines](#multiple-docks--machines)
below).

## Layout

Each top-level directory is a stow package that mirrors `$HOME`:

```
hypr/.config/hypr/...   ghostty/.config/ghostty/...   nvim/.config/nvim/...
zsh/...                 bash/...                      starship/...   vimrc/...
```

## Install / apply

```sh
./dotfiles.sh
```

This removes Omarchy's stock `~/.config/hypr/{monitors,input,looknfeel,bindings,autostart}.lua`
(Omarchy 4's designated user-override files, shipped there as real files) and
a few other generated files, then `stow`s every package so `~/.config/...`
becomes symlinks back into this repo. Safe to re-run any time; if
`omarchy refresh hyprland` (or an Omarchy upgrade) ever overwrites those
symlinks with real files again, re-running `./dotfiles.sh` restores them —
nothing is lost, since it was writing into this git repo in the first place.

`./install.sh` only installs the `stow`/`zsh` prerequisites; it does not
apply the dotfiles. Run `./dotfiles.sh` to actually link everything.

## Multiple docks / machines

`hypr/.config/hypr/monitors.lua` picks its monitor layout by machine
(`/etc/hostname`), and — since the same laptop gets docked in more than one
physical location under the same hostname — by a **profile** within that
machine's entry:

```lua
local hosts = {
	edge = {
		profile = "home", -- "office" | "home"
		profiles = {
			office = { monitors = { ... }, workspaces = { ... } },
			home   = { monitors = { ... }, workspaces = { ... } },
		},
	},
}
```

**Switching docks on an existing machine:** edit the `profile` field to the
dock you're currently on and reload:

```sh
$EDITOR ~/.dotfiles/hypr/.config/hypr/monitors.lua   # set profile = "office" | "home"
hyprctl reload
hyprctl configerrors   # should print nothing
```

**Adding a new dock profile:** run `hyprctl monitors all` while plugged into
it, add a new entry under `profiles`, and point `profile` at it.

**Adding a new machine:** copy the `edge` block, key it by the new machine's
`hostname` (from `/etc/hostname`), and fill in `monitors`/`workspaces` (a
single flat profile, or multiple like `edge` if that machine also has more
than one dock). An unlisted machine still comes up fine — every display at
its preferred mode, no workspace pinning — the catch-all at the bottom of
`monitors.lua` handles it.

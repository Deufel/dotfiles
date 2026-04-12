# dotfiles

Mike Deufel — Omarchy (Arch/Hyprland) on Apple M1 via Asahi Alarm.

## Dependencies
- `stow` — `sudo pacman -S stow`

## Install
git clone git@github.com:Deufel/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow hypr bash ssh bin stowrc

## Helpers
- `stow-add <package> <file>` — move a file into dotfiles and symlink it
- `stow-list` — show all active symlinks, counts, and git status

## Adding a new config file
stow-add hypr ~/.config/hypr/hypridle.conf
git add . && git commit -m "add hypridle"

## Contents
- `hypr/` — Hyprland config (monitors, bindings, looknfeel, input, autostart, hypridle)
- `bash/` — .bashrc additions, PATH, SSH agent
- `ssh/` — ~/.ssh/config (keys not included)
- `bin/` — personal scripts (sshkeys, stow-add, stow-list)
- `stowrc/` — stow defaults (~/.stowrc)

## Notes
- SSH keys must be generated separately: `ssh-keygen -t ed25519 -C "label" -f ~/.ssh/keyname`
- After stow, reload Hyprland: `hyprctl reload`
- Omarchy defaults live in `~/.local/share/omarchy/` — don't edit directly

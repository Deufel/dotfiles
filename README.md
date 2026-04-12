# dotfiles

Mike Deufel — Omarchy (Arch/Hyprland) on Apple M1 via Asahi Alarm.

## Dependencies
- `stow` — `sudo pacman -S stow`

## Install
git clone git@github.com:Deufel/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow hypr bash ssh bin

## Adding a new config file
cp ~/.config/path/to/file ~/dotfiles/package/.config/path/to/file
rm ~/.config/path/to/file
stow --dir=/home/mike/dotfiles --target=/home/mike package
git add . && git commit -m "add filename"

## Contents
- `hypr/` — Hyprland config (monitors, bindings, looknfeel, input, autostart)
- `bash/` — .bashrc additions, PATH, SSH agent
- `ssh/` — ~/.ssh/config (keys not included)
- `bin/` — personal scripts (`sshkeys`)

## Notes
- SSH keys must be generated separately: `ssh-keygen -t ed25519 -C "label" -f ~/.ssh/keyname`
- After stow, reload Hyprland: `hyprctl reload`
- Omarchy defaults live in `~/.local/share/omarchy/` — don't edit directly

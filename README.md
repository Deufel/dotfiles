# dotfiles

Mike Deufel — Omarchy (Arch/Hyprland) on Apple M1 via Asahi Alarm.

## Overview
New Install     Weekly Timer    Manual Updates
        │              │              │
        ▼              ▼              ▼
$ curl install.sh  $ dotfiles-save  $ stow-add <pkg> <file>
                                     $ git push
        │              │              │
        └──────────────┼──────────────┘
                       │
                       ▼
                 ~/dotfiles/
                 (git repo)
                 • symlinked configs
                 • packages.txt
                 • aur.txt

## Install
curl -fsSL https://raw.githubusercontent.com/Deufel/dotfiles/master/install.sh | sh

## Helpers
- `stow-add <package> <file>` — move a file into dotfiles and symlink it
- `stow-list` — show all active symlinks, counts, and git status
- `dotfiles-save` — update package lists and push to git

## Adding a new config file
stow-add hypr ~/.config/hypr/hypridle.conf
git add . && git commit -m "add hypridle"


## Notes
- SSH keys must be generated separately: `ssh-keygen -t ed25519 -C "label" -f ~/.ssh/keyname`
- After stow, reload Hyprland: `hyprctl reload`
- Omarchy defaults live in `~/.local/share/omarchy/` — don't edit directly

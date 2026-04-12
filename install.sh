#!/bin/bash
# Bootstrap dotfiles on a fresh Omarchy/Arch install.
# curl -fsSL https://raw.githubusercontent.com/Deufel/dotfiles/master/install.sh | sh

DOTFILES=~/dotfiles
REPO="git@github.com:Deufel/dotfiles.git"
PACKAGES="hypr bash ssh bin stowrc nvim"
BACKUP=~/.dotfiles-backup

fail() {
  echo "✗ $1" >&2
  exit 1
}
ok() { echo "✓ $1"; }
info() { echo "→ $1"; }

# check arch
[ ! -f /etc/arch-release ] && fail "this script is for Arch Linux only"

# check git
command -v git &>/dev/null || fail "git is not installed"

# check ssh key for github
[ ! -f ~/.ssh/github ] && fail "no SSH key found at ~/.ssh/github — set up SSH first:\n  ssh-keygen -t ed25519 -C \"github\" -f ~/.ssh/github"

# install stow if needed
if ! command -v stow &>/dev/null; then
  info "installing stow"
  sudo pacman -S --noconfirm stow || fail "could not install stow"
fi
ok "stow ready"

# clone repo
if [ -d "$DOTFILES" ]; then
  info "~/dotfiles already exists, pulling latest"
  git -C "$DOTFILES" pull || fail "could not pull dotfiles"
else
  info "cloning dotfiles"
  git clone "$REPO" "$DOTFILES" || fail "could not clone repo"
fi
ok "dotfiles repo ready"

# backup and stow each package
mkdir -p "$BACKUP"
for pkg in $PACKAGES; do
  info "stowing $pkg"
  if ! stow --dir="$DOTFILES" --target="$HOME" "$pkg" 2>/dev/null; then
    info "conflict in $pkg — backing up and retrying"
    stow --dir="$DOTFILES" --target="$HOME" --adopt "$pkg" 2>/dev/null
    # move adopted files to backup, restore dotfiles versions
    git -C "$DOTFILES" checkout -- .
    stow --dir="$DOTFILES" --target="$HOME" "$pkg" || fail "could not stow $pkg after backup"
  fi
  ok "stowed $pkg"
done

# reload hyprland if running
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
  hyprctl reload
  ok "hyprland reloaded"
fi

echo ""
echo "── done ──────────────────────────────"
echo "── next steps ────────────────────────"
echo "  SSH key:  ssh-keygen -t ed25519 -C \"github\" -f ~/.ssh/github"
echo "            cat ~/.ssh/github.pub | wl-copy"
echo "            # paste into github.com/settings/keys"
echo "  Git:      git config --global user.name \"Mike Deufel\""
echo "            git config --global user.email \"MDeufel13@gmail.com\""

#!/bin/bash
# Bootstrap dotfiles on a fresh Omarchy/Arch install.
# curl -fsSL https://raw.githubusercontent.com/Deufel/dotfiles/master/install.sh | sh

REPO="https://github.com/Deufel/dotfiles.git"

fail() {
  echo "✗ $1" >&2
  exit 1
}
ok() { echo "✓ $1"; }
info() { echo "→ $1"; }

# guards Not needed but does nto hurt i guess..
[ ! -f /etc/arch-release ] && fail "Arch Linux only"
command -v git &>/dev/null || fail "git is not installed"

# install stow if needed
if ! command -v stow &>/dev/null; then
  info "installing stow"
  sudo pacman -S --noconfirm stow || fail "could not install stow"
fi
ok "stow ready"

# clone or update
if [ -d $HOME/dotfiles ]; then
  info "$HOME/dotfiles exists, pulling latest"
  git -C $HOME/dotfiles pull || fail "could not pull"
else
  info "cloning dotfiles"
  git clone "$REPO" $HOME/dotfiles || fail "could not clone"
fi
ok "dotfiles ready"

# stow all packages — derived from repo structure, no hardcoded list
while IFS= read -r pkg_path; do
  pkg=$(basename "$pkg_path")
  if ! stow --dir=$HOME/dotfiles --target="$HOME" "$pkg" 2>/dev/null; then
    info "conflict in $pkg — adopting and restoring"
    stow --dir=$HOME/dotfiles --target="$HOME" --adopt "$pkg" 2>/dev/null
    git -C $HOME/dotfiles checkout -- .
    stow --dir=$HOME/dotfiles --target="$HOME" "$pkg" || fail "could not stow $pkg"
  fi
  ok "stowed $pkg"
done < <(find $HOME/dotfiles -maxdepth 1 -mindepth 1 -type d -not -name ".git")

# reload hyprland if running
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
  hyprctl reload
  ok "hyprland reloaded"
fi

echo ""
echo "── next steps (in order) ─────────────"
echo "  1. ssh-keygen -t ed25519 -C \"github\" -f $HOME/.ssh/github"
echo "     cat $HOME/.ssh/github.pub | wl-copy"
echo "     # paste into github.com/settings/keys"
echo "  2. git config --global user.name \"Mike Deufel\""
echo "     git config --global user.email \"MDeufel13@gmail.com\""
echo "  3. cd $HOME/dotfiles && git fetch"

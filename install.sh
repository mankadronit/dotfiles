#!/usr/bin/env bash
# install.sh — copy the tracked dotfiles into place.
# Idempotent: re-running updates existing files and backs up any changed file
# it would overwrite (to <path>.bak.<timestamp>). Safe to run repeatedly.
# The repo can be deleted after install — all configs are real files, not symlinks.
#
# Usage:
#   ./install.sh            # copy all dotfiles
#   ./install.sh --dry-run  # print what it would do, change nothing

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

# If dst is a symlink (left over from a previous symlink-based install), remove it
# so we can replace it with a real file/directory.
_remove_symlink() {
    local dst="$1"
    if [ -L "$dst" ]; then
        [ "$DRY_RUN" = 1 ] && echo "would remove old symlink $dst" && return
        rm "$dst"
        echo "removed old symlink $dst"
    fi
}

# Copy a single file from the repo to its destination.
install_file() {
    local src="$DOTFILES/$1" dst="$2"
    if [ ! -e "$src" ]; then
        echo "SKIP  (missing in repo): $1"
        return
    fi
    if [ "$DRY_RUN" = 1 ]; then
        echo "would copy $src -> $dst"
        return
    fi
    mkdir -p "$(dirname "$dst")"
    _remove_symlink "$dst"
    if [ -f "$dst" ] && diff -q "$src" "$dst" > /dev/null 2>&1; then
        echo "ok    $dst"
        return
    fi
    if [ -e "$dst" ]; then
        mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
        echo "backed up $dst"
    fi
    cp "$src" "$dst"
    echo "copied $dst"
}

# Sync a whole directory from the repo into the destination using rsync.
# Existing destination-only files are left alone (no --delete).
install_dir() {
    local src="$DOTFILES/$1" dst="$2"
    if [ ! -d "$src" ]; then
        echo "SKIP  (missing in repo): $1"
        return
    fi
    if [ "$DRY_RUN" = 1 ]; then
        echo "would sync $src/ -> $dst/"
        return
    fi
    _remove_symlink "$dst"
    mkdir -p "$dst"
    rsync -a "$src/" "$dst/"
    echo "ok    $dst/"
}

# --- whole directories -----------------------------------------------------
install_dir config/nvim    "$HOME/.config/nvim"
install_dir config/tmux    "$HOME/.config/tmux"
install_dir config/ghostty "$HOME/.config/ghostty"
install_dir config/lf      "$HOME/.config/lf"

# --- single files ----------------------------------------------------------
install_file config/starship.toml "$HOME/.config/starship.toml"
install_file config/git/ignore    "$HOME/.config/git/ignore"
install_file home/.gitconfig      "$HOME/.gitconfig"

# --- fish (only hand-authored bits; fisher reinstalls the plugin files) -----
install_file config/fish/config.fish               "$HOME/.config/fish/config.fish"
install_file config/fish/fish_plugins              "$HOME/.config/fish/fish_plugins"
install_file config/fish/conf.d/abbreviations.fish "$HOME/.config/fish/conf.d/abbreviations.fish"
install_file config/fish/conf.d/aliases.fish       "$HOME/.config/fish/conf.d/aliases.fish"
install_file config/fish/conf.d/vi-mode.fish       "$HOME/.config/fish/conf.d/vi-mode.fish"
install_file config/fish/functions/lf.fish         "$HOME/.config/fish/functions/lf.fish"

echo
echo "Done. New machine? See README.md for the bootstrap steps (brew bundle,"
echo "fisher, TPM, nvim plugin sync)."
echo
echo "Tip: configs are real copies — edits to ~/.config/nvim etc. are local only."
echo "To pull repo updates, re-run install.sh from the dotfiles directory."

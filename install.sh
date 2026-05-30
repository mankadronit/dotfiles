#!/usr/bin/env bash
# install.sh — symlink the tracked dotfiles into place.
# Idempotent: re-running repoints existing symlinks and backs up any real file
# it would overwrite (to <path>.bak.<timestamp>). Safe to run repeatedly.
#
# Usage:
#   ./install.sh            # create/refresh all symlinks
#   ./install.sh --dry-run  # print what it would do, change nothing

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

link() {
	local src="$DOTFILES/$1" dst="$2"
	if [ ! -e "$src" ]; then
		echo "SKIP  (missing in repo): $1"
		return
	fi
	if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
		echo "ok    $dst"
		return
	fi
	if [ "$DRY_RUN" = 1 ]; then
		echo "would link $dst -> $src"
		return
	fi
	mkdir -p "$(dirname "$dst")"
	if [ -L "$dst" ]; then
		rm "$dst"
	elif [ -e "$dst" ]; then
		mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
		echo "backed up existing $dst"
	fi
	ln -s "$src" "$dst"
	echo "linked $dst -> $src"
}

# --- whole directories -----------------------------------------------------
link config/nvim    "$HOME/.config/nvim"
link config/tmux    "$HOME/.config/tmux"
link config/ghostty "$HOME/.config/ghostty"
link config/lf      "$HOME/.config/lf"

# --- single files ----------------------------------------------------------
link config/starship.toml "$HOME/.config/starship.toml"
link config/git/ignore    "$HOME/.config/git/ignore"
link home/.gitconfig      "$HOME/.gitconfig"

# --- fish (only hand-authored bits; fisher reinstalls the plugin files) -----
link config/fish/config.fish               "$HOME/.config/fish/config.fish"
link config/fish/fish_plugins              "$HOME/.config/fish/fish_plugins"
link config/fish/conf.d/abbreviations.fish "$HOME/.config/fish/conf.d/abbreviations.fish"
link config/fish/conf.d/aliases.fish       "$HOME/.config/fish/conf.d/aliases.fish"
link config/fish/conf.d/vi-mode.fish       "$HOME/.config/fish/conf.d/vi-mode.fish"
link config/fish/functions/lf.fish         "$HOME/.config/fish/functions/lf.fish"

echo
echo "Done. New machine? See README.md for the bootstrap steps (brew bundle,"
echo "fisher, TPM, nvim plugin sync)."

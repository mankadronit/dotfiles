# dotfiles

Personal macOS development environment — **fish**, **Neovim**, **tmux**, **Ghostty**,
**starship**. Managed as a symlink repo: the real files live here and are
symlinked into `~/.config` (and `~`) by [`install.sh`](install.sh).

Heavily inspired by [radleylewis/dotfiles](https://github.com/radleylewis/dotfiles),
[radleylewis/nvim](https://github.com/radleylewis/nvim), and
[radleylewis/zsh](https://github.com/radleylewis/zsh) — adapted for macOS and
fish (instead of his Linux/Wayland + zsh setup), and kept on a modern 2026
Neovim stack (blink.cmp, snacks.nvim, native LSP).

## Layout

```
config/
  fish/          config.fish, fish_plugins, conf.d/* , functions/lf.fish
  nvim/          full Neovim config (lazy.nvim; lazy-lock.json pins versions)
  tmux/          tmux.conf + scripts/ (session/scratch/ssh popups)
  ghostty/       terminal config + themes
  lf/            file-manager config (lfrc + preview)
  git/ignore     global gitignore
  starship.toml  prompt
home/
  .gitconfig
Brewfile         every tool these dotfiles assume
install.sh       symlinks everything into place (idempotent)
```

Only **hand-authored** fish files are tracked. Fisher reinstalls the plugin
files (autopair, fzf.fish, fisher itself) from `fish_plugins`.

## Install on a fresh machine

```sh
# 1. Clone
git clone <this-repo-url> ~/dotfiles && cd ~/dotfiles

# 2. Install tools
brew bundle               # reads ./Brewfile

# 3. Symlink the configs into place (backs up anything it would overwrite)
./install.sh

# 4. fish: make it the default shell + install plugins
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"

# 5. tmux: install TPM + plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# 6. Neovim: install plugins (lazy auto-bootstraps on first launch)
nvim --headless "+Lazy! sync" +qa
```

`install.sh` is safe to re-run anytime (e.g. after `git pull`); it only creates
or repoints symlinks and backs up real files to `*.bak.<timestamp>`.

## Day-to-day

- **Edit a config** → edit it under `~/.config/...` as usual; it's a symlink, so
  you're editing the file in this repo. `cd ~/dotfiles && git diff` to review.
- **Add a new tracked file** → put it in the repo, add a `link` line to
  `install.sh`, run `./install.sh`.

## Highlights

### tmux (`prefix = C-a`)
Top status bar, vi copy-mode, splits `|` / `-`, repeatable `prefix h/j/k/l`
resize, and popups: `prefix g` lazygit · `prefix w` session switcher ·
`prefix T` scratchpad · `prefix S` ssh menu. Sessions auto-save/restore
(resurrect + continuum). Yank → system clipboard via tmux-yank.

### Neovim (leader = `space`)
Modern stack: blink.cmp, snacks.nvim (picker + explorer + lazygit), native
`vim.lsp` config, conform formatting, treesitter (main).
- **LSP**: lua, python (basedpyright + ruff), TS/JS, C/C++, Docker, YAML.
  Rust is owned by **rustaceanvim** (clippy on save, debuggables).
- **Debugging**: nvim-dap + dap-ui (`<leader>d…`), codelldb.
- **Extras**: trouble (`<leader>x`), zen-mode (`<leader>z`), obsidian
  (`<leader>o`, vault `~/Documents/Notes`), markdown-preview (`<leader>mp`),
  ccc colour picker (`<leader>cp`).
- **Go**: parser + formatter mappings are present but the toolchain isn't
  auto-installed — run `brew install go` then
  `:MasonInstall gopls gofumpt goimports`.

### fish
Abbreviations (git/cargo), eza/bat/lazygit aliases, **vi key bindings**
(`conf.d/vi-mode.fish`), zoxide, starship, fzf.fish, autopair. `lf` is wrapped
so it `cd`s to the directory you quit in.

## Not included (Linux-only, intentionally skipped)
qtile, kanshi, mako, rofi, swaylock/wf-recorder, alacritty, nmcli scripts — all
from the reference repos but irrelevant on macOS.

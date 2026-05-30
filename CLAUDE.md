# CLAUDE.md — guidance for AI agents working in this repo

This is a **macOS** dotfiles repo (fish + Neovim + tmux + Ghostty + starship),
managed as a **symlink repo**. The real files live here; `install.sh` symlinks
them into `~/.config` and `~`. Editing `~/.config/nvim/...` edits this repo
(it's a symlink) — there is no separate copy to keep in sync.

## Golden rules

- **macOS only.** Do not add Linux/Wayland tooling (qtile, mako, rofi, swaylock,
  nmcli, xdg-open, alacritty). Use macOS equivalents (`open`, `pbcopy`, Ghostty).
- **Keep the Neovim stack modern.** It deliberately uses blink.cmp (not
  nvim-cmp), snacks.nvim (not telescope/neo-tree/fzf-lua), and the native
  `vim.lsp.config`/`vim.lsp.enable` API (not the `lspconfig` setup wrapper).
  Do not "upgrade" to older patterns. Rust is owned by **rustaceanvim** — never
  also enable `rust_analyzer` through mason-lspconfig (double attach).
- **Don't track generated state.** Neovim plugin code/data lives in
  `~/.local/share/nvim` and `~/.local/state/nvim`, never here. Fish plugin files
  (autopair, fzf.fish) are installed by fisher from `fish_plugins` — only
  hand-authored fish files are tracked. See `.gitignore`.
- **`lazy-lock.json` IS tracked** — it pins plugin versions. Commit changes to it
  when you intentionally update plugins.
- **No secrets.** Never commit tokens, keys, or anything machine-private.

## Structure

| Path | What | How it's linked |
|------|------|-----------------|
| `config/nvim/` | Neovim (lazy.nvim, specs in `lua/plugins/*.lua`) | whole dir |
| `config/tmux/` | tmux.conf + `scripts/` popups | whole dir |
| `config/ghostty/` | terminal config + themes | whole dir |
| `config/lf/` | lf file manager (`lfrc`, `preview`) | whole dir |
| `config/fish/` | only `config.fish`, `fish_plugins`, hand-authored `conf.d/*` + `functions/lf.fish` | per file |
| `config/starship.toml`, `config/git/ignore`, `home/.gitconfig` | misc | per file |

To track a **new** file: add it under the repo, add a matching `link` line in
`install.sh`, and run `./install.sh`.

## Conventions

- **Neovim**: one plugin per file in `lua/plugins/`. Match the existing heavily
  commented style (a header comment explaining *why* the plugin/setting exists).
  Keymaps live next to their plugin spec; cross-cutting keymaps in
  `lua/config/keymaps.lua`. New `<leader>` prefixes get a `which-key` group.
- **tmux**: prefix is `C-a`. Config is XDG (`~/.config/tmux/tmux.conf`); TPM
  lives at `~/.tmux/plugins`.
- **fish**: prefer **abbreviations** over aliases for commands you want to see
  expanded (git). Interactive-only code guards with `status is-interactive`.

## Verifying changes

- Neovim loads clean: `nvim --headless +qa` (no output = good); load-test a spec
  with `nvim --headless -c "lua dofile('config/nvim/lua/plugins/X.lua')" -c qa`.
- tmux parses: `tmux -L test -f config/tmux/tmux.conf new-session -d \; kill-server`.
- fish parses: `fish -n config/fish/config.fish`.
- After editing `install.sh`, dry-run it: `./install.sh --dry-run`.

## Git

- Commit messages: imperative, scoped (e.g. `nvim: add trouble.nvim`).
- **Do not** add a `Co-Authored-By: Claude` trailer (user preference).

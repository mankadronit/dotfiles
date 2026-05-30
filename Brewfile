# Brewfile — `brew bundle` from the repo root installs everything these
# dotfiles assume. Keep this in sync when you add tools.

# Shell + prompt
brew "fish"
brew "starship"
brew "zoxide"

# Editor + multiplexer
brew "neovim"
brew "tmux"

# Modern CLI replacements / tools used by configs + keymaps
brew "fzf"        # fuzzy finder (fish bindings, tmux popups)
brew "ripgrep"    # rg — grep replacement, nvim live-grep backend
brew "fd"         # find replacement, fzf default command
brew "eza"        # ls replacement (aliases)
brew "bat"        # cat/pager with syntax highlighting
brew "lazygit"    # git TUI (tmux prefix+g, nvim <leader>gg)
brew "lf"         # terminal file manager
brew "git"

# Terminal emulator + font (casks)
cask "ghostty"
cask "font-fira-code-nerd-font"

# Optional / language toolchains (uncomment as needed):
# brew "go"       # enables gopls + gofumpt/goimports (then :MasonInstall gopls gofumpt goimports)
# rustup is managed outside brew (https://rustup.rs); rust-analyzer comes with it

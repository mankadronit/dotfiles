# ~/.config/fish/conf.d/aliases.fish
# Aliases for modern CLI replacements. Auto-loaded by fish on every session.

# eza — a modern `ls` with icons + git status.
alias ls 'eza --group-directories-first --icons=auto'
alias ll 'eza -l --group-directories-first --icons=auto --git'
alias la 'eza -la --group-directories-first --icons=auto --git'
alias lt 'eza --tree --level=2 --icons=auto'

# bat — `cat` with syntax highlighting (kept under `bat`, `cat` untouched).
alias catp 'bat --paging=never'

# git / editor shortcuts
alias g git
alias lg lazygit
alias v nvim
alias vim nvim

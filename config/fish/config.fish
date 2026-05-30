# ~/.config/fish/config.fish
# Main fish config. Modular bits live in conf.d/*.fish (auto-loaded) and
# functions/*.fish (auto-loaded on first call).

# ---------------------------------------------------------------------------
# Environment
# ---------------------------------------------------------------------------
set -gx EDITOR nvim
set -gx VISUAL nvim
# Use bat as the pager for man pages (colourised).
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# PATH additions (idempotent — fish_add_path won't create duplicates).
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/bin

# ---------------------------------------------------------------------------
# Interactive-only setup
# ---------------------------------------------------------------------------
if status is-interactive
    # Prompt
    starship init fish | source

    # Smarter `cd`: `z foo` jumps to the best match, `zi` is interactive.
    zoxide init fish | source

    # Disable the default fish greeting.
    set -g fish_greeting
end

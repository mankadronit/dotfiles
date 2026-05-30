# ~/.config/fish/conf.d/vi-mode.fish
# Vi key bindings for fish (equivalent of the reference's zsh-vi-mode).
# Loads after fzf.fish (alphabetical) so its bindings can be re-layered on top.
# autopair re-applies itself automatically via its own fish_key_bindings hook.

status is-interactive || exit

# Enabling vi mode runs fish_vi_key_bindings and then calls
# fish_user_key_bindings, where we re-apply the fzf.fish bindings (vi mode wipes
# them otherwise).
set -g fish_key_bindings fish_vi_key_bindings

function fish_user_key_bindings
    if functions -q fzf_configure_bindings
        fzf_configure_bindings
    end
end

# Per-mode cursor shapes (Ghostty honours DECSCUSR).
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

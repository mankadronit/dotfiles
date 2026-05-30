# ~/.config/fish/conf.d/abbreviations.fish
# Abbreviations expand inline as you type (you see the full command before
# running it), which is friendlier than aliases for git. Auto-loaded.

if status is-interactive
    abbr -a gs git status
    abbr -a ga git add
    abbr -a gaa git add --all
    abbr -a gc git commit
    abbr -a gcm git commit -m
    abbr -a gco git checkout
    abbr -a gcb git checkout -b
    abbr -a gp git push
    abbr -a gpl git pull
    abbr -a gd git diff
    abbr -a gl git log --oneline --graph --decorate
    abbr -a gla git log --all --decorate --oneline --graph
    abbr -a gb git branch

    # cargo / python conveniences
    abbr -a cr cargo run
    abbr -a cb cargo build
    abbr -a ct cargo test
    abbr -a cc cargo clippy
    abbr -a py python3
end

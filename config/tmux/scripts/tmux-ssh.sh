#!/usr/bin/env sh
# Pick an SSH host from ~/.ssh/config and open it in a new window.

host=$(grep '^Host ' ~/.ssh/config 2>/dev/null | awk '{print $2}' | grep -v '\*' | fzf --prompt="SSH: ")

[ -z "$host" ] && exit 0

tmux new-window -n "$host" "ssh $host"

#!/usr/bin/env zsh

# This script creates a new tmux session if launching zsh from a terminal or
# other non-tmux context.
#
# Bugs:
# * .zshrc is sourced twice on startup in these cases

if command -v tmux &>/dev/null; then
    if [[ -z "$TMUX" ]]; then # prevent this script from running twice on startup
        tmux new-session
        exit 0 # exit out after the session ends or is detached
    fi
fi

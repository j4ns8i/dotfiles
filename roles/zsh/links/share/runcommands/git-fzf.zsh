# Step 1: Define shell functions
_git_branches() {
    zle push-input
    local branch="$(git branch -a --format '%(refname:short)' | fzf ${=FZF_GIT_OPTS})"
    zle -U "$branch"
    zle -U "$CUTBUFFER"
    zle accept-line
}

_git_ls() {
    zle push-input
    local commit="$(git ls --color | fzf --ansi ${=FZF_GIT_OPTS} | awk '{print $1}')"
    zle -U "$commit"
    zle -U "$CUTBUFFER"
    zle accept-line
}

# Step 2: Create a new ZLE command and bind it to your shell function
zle -N _git_branches
zle -N _git_ls

# Step 3: Bind your new ZLE command to a key sequence
bindkey -r "^g"
bindkey "^[gb" _git_branches
bindkey "^[gc" _git_ls

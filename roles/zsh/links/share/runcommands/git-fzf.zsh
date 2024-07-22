# Step 1: Define shell functions
git-branches() {
    local branch="$(git branch -a --format '%(refname:short)' | fzf ${=FZF_GIT_OPTS})"
    LBUFFER="${LBUFFER}${branch}"
}

git-ls() {
    local branch="$(git ls --color | fzf --ansi ${=FZF_GIT_OPTS} | awk '{print $1}')"
    LBUFFER="${LBUFFER}${branch}"
}

# Step 2: Create a new ZLE command and bind it to your shell function
zle -N git-branches
zle -N git-ls

# Step 3: Bind your new ZLE command to a key sequence
bindkey -r "^g"
bindkey "^[gb" git-branches
bindkey "^[gc" git-ls

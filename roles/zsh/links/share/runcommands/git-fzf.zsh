# Step 1: Define a shell function
git-branches() {
    local branch="$(git branch -a --format '%(refname:short)' | fzf ${=FZF_GIT_OPTS})"
    LBUFFER="${LBUFFER}${branch}"
}

# Step 2: Create a new ZLE command and bind it to your shell function
zle -N git-branches

# Step 3: Bind your new ZLE command to a key sequence
bindkey -r "^g"
bindkey "^[gb" git-branches

# Step 1: Define shell functions
_git_branches() {
    local cursor=$CURSOR
    zle push-input
    local output=($(git branch -a --color=always --format \
        '%(color:blue)%(refname:short)%(color:reset) (%(color:yellow)%(objectname:short=8)%(color:reset) from %(color:green)%(authordate:relative)%(color:reset))' \
        | fzf --ansi --multi ${=FZF_GIT_OPTS} \
        | awk '{print $1}' ))
    zle reset-prompt
    zle get-line
    zle -U "$output"
    CURSOR=$cursor
}

_git_ls() {
    local cursor=$CURSOR
    zle push-input
    local output=($(git ls --color=always | fzf --no-sort --ansi --multi ${=FZF_GIT_OPTS} | awk '{print $1}'))
    zle reset-prompt
    zle get-line
    zle -U "$output"
    CURSOR=$cursor
}

_git_reflog() {
    local cursor=$CURSOR
    zle push-input
    local output=($(git reflog --color=always --decorate=short | fzf --no-sort --ansi --multi ${=FZF_GIT_OPTS} | awk '{print $1}'))
    zle reset-prompt
    zle get-line
    zle -U "$output"
    CURSOR=$cursor
}


# Step 2: Create a new ZLE command and bind it to your shell function
zle -N _git_branches
zle -N _git_ls
zle -N _git_reflog

# Step 3: Bind your new ZLE command to a key sequence
bindkey -r "^g"
bindkey "^[gb" _git_branches
bindkey "^[gc" _git_ls
bindkey "^[gr" _git_reflog

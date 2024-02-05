# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # color completions according to LS_COLORS
# zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' menu select # highlight selected menu items
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/Users/jsmalkowski/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U zmv
autoload -U promptinit; promptinit
zstyle :prompt:pure:prompt:success color 2
zstyle :prompt:pure:prompt:error   color 1
zstyle :prompt:pure:virtualenv     color 8
zstyle :prompt:pure:git:branch     color 8
zstyle :prompt:pure:git:action     color 8
zstyle :prompt:pure:git:dirty      color 13
zstyle :prompt:pure:git:arrow      color 6
prompt pure

# load fzf configuration
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# Set command line editing mode to emacs
bindkey -e

# Set terminal + keyboard specific key shortcuts, if defined. This file can be generated by running `autoload zkbd && zkbd`
[[ -f "$HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}" ]] && source $HOME/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}

# <up> and <down> searches history for something beginning with the current line (up to the cursor)
bindkey "${key[Up]}"   history-beginning-search-backward
bindkey "${key[Down]}" history-beginning-search-forward

# shift-tab reverses menu completion
bindkey '^[[Z' reverse-menu-complete

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

export LANG=en_US.UTF-8
export BASE=~/code
export EDITOR=nvim
export GOPATH=${BASE}
export GIT_PAGER="less -FRX"
export LESS="-R -j 10"
export SRC=${BASE}/src
export TRACKS_DIR=${HOME}/scratch/tracks
# export PURE_PREPROMPT='%F{blue}%2~%f'
export WORDCHARS=${WORDCHARS/\/}
export PYENV_ROOT=~/.pyenv

# Make ctrl-R full screen with fzf
export FZF_DEFAULT_OPTS='--height=100% --exact --layout=default'

# Add new paths to $PATH if they dont already exist
function add_to_path() {
    [[ ${${(s.:.)PATH}[(i)${@}]} -gt ${#${(s.:.)PATH}} ]] && export PATH="${@}:${PATH}"
}

add_to_path "/usr/local/bin"
add_to_path "/usr/local/sbin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$GOPATH/bin"
add_to_path "${PYENV_ROOT}/bin"
add_to_path "${PYENV_ROOT}/shims"
add_to_path "$HOME/.nvm"

command -v pyenv &>/dev/null && eval "$(pyenv init -)"

# macOS-specific aliases
if [[ "$(uname -s)" == "Darwin" ]]; then
    alias ls='gls --color' # coreutils homebrew package
    alias updatedb="sudo /usr/libexec/locate.updatedb"

    # from coreutils brew formula
    eval $(gdircolors)
else
    alias ls="ls --color"
    eval $(dircolors)
fi

alias l='ls --color -AF'
alias ll='ls --color -AlhF'
alias llt='ls --color -thrAlF'
alias vim="nvim"
alias vimdiff="nvim -d"
alias view="nvim -R"
alias evrc="vim ~/.vimrc"
alias elocal="vim ~/.config/zsh/runcommands/local.zsh; source ~/.config/zsh/runcommands/local.zsh"
alias k=kubectl
alias -g L="| less"

function ggo {
    # Go to a github organization
    MAX_DEPTH=2
    DIR=$(find $SRC -maxdepth $MAX_DEPTH -type d -name ${1});
    if [[ -d $DIR ]]; then
        cd $DIR;
    else
        echo "${1} could not be found under $SRC with a max depth of $MAX_DEPTH";
        return 1
    fi
}

# quick way of finding a git repo with any number of given path components:
# $ find $SRC -type d -execdir test -d \{\}/.git \; -prune -path \*/<PATH> -print
function ggr {
    # Go to a github repository
    MAX_DEPTH=3
    DIR=$(find $SRC -maxdepth $MAX_DEPTH -type d -name ${1});
    if [[ -d $DIR ]]; then
        cd $DIR;
    else
        echo "${1} could not be found under $SRC with a max depth of $MAX_DEPTH";
        return 1
    fi
}

function show_colors {
    for x in 0 1 4 5 7 8; do
        for i in {30..37}; do
            for a in {40..47}; do
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
        done
    done
    echo ""
}

compdef "_files -W ${TRACKS_DIR}" track
function track {
    if [[ "${1}" == "" ]]; then
        echo "ERROR: File name required" >&2
        return 1
    fi

    FILE_NAME=${TRACKS_DIR}/${1}
    if [[ ! -f "${FILE_NAME}" ]]; then
        # add date (and .md) to name of file
        FILE_NAME="${FILE_NAME}.$(date +%Y%m%d).md"
    fi
    vim $FILE_NAME
}

function alnum {
    cat /dev/urandom | gtr -dc 'a-z0-9' | head -c ${1:-8}
}

function alerton {
    eval ${(q@)@}
    local comm="${@}"
    osascript -e 'display alert "Done" message "'"${comm}"' has finished"' 1>/dev/null
}

function clone {
    # Check if no arguments given
    if [[ "${#@[@]}" -eq 0 ]]; then
        echo "Error: expecting a repository" >&2
        return 1
    fi

    # Check if any argument is malformed.
    for arg in ${@[@]}; do
        # If the argument doesn't look like a github repo, which is assumed to
        # look like github.com:jsmalkowski/dotfiles or (site[:/])?(org)/(repo)
        #
        # Site is optional, defaults to github.com.
        # If : is specified, uses ssh protocol.
        # If / is specified, uses https protocol
        if [[ ! "${arg//[^:\/]}" =~ "^[:/]?/$" ]] ||
                [[ ${#${=arg//[:\/]/ }} -ne $(( ${#arg//[^:\/]} + 1 )) ]]; then
            echo "Bad pattern: $arg" >&2
            echo "Expecting (site[:/])(org)/(repo)" >&2
            return 1
        fi
    done

    # Here's where the magic happens
    for arg in ${@[@]}; do
        # Determine the protocol for cloning
        local protocol separator
        if [[ "${arg//[^:\/]}" = ":/" ]]; then
            protocol='git@'
            separator=':'
        else
            protocol='https://'
            separator='/'
        fi

        # Split argument into array of ( optional_site org repo )
        local arg_array=( ${=arg//[:\/]/ } )

        # Determine the site to clone from
        local site org repo
        if [[ "${#arg_array}" -eq 3 ]]; then
            site="${arg_array[1]}"
            org="${arg_array[2]}"
            repo="${arg_array[3]}"
        else
            site="github.com"
            org="${arg_array[1]}"
            repo="${arg_array[2]}"
        fi

        # Create the directory and clone it
        mkdir -p $SRC/$site/$org
        git -C $SRC/$site/$org clone ${protocol}${site}${separator}${org}/${repo}
    done
}

#########################
#                       #
# History Configuration #
#                       #
#########################

if [ -z $HISTFILE ]; then
    export HISTFILE=$HOME/.zsh_history
fi
export HISTSIZE=100000
export SAVEHIST=100000

# Push directories from cd onto the directory stack
setopt AUTO_PUSHD

# But don't push duplicate directories
setopt PUSHD_IGNORE_DUPS

# Save each command's beginning timestamp in HISTFILE
setopt EXTENDED_HISTORY

# Treat '#', '~', and '^' as part of patterns for filename generation
setopt EXTENDED_GLOB

# When searching through history, ignore any duplicates
setopt HIST_FIND_NO_DUPS

# Only record last instance of a command
setopt HIST_IGNORE_ALL_DUPS

# Don't record lines with a leading space
setopt HIST_IGNORE_SPACE

# Verify history expansions in command before execution
setopt HIST_VERIFY

# Incrementally append to HISTFILE and import HISTFILE on each prompt
setopt SHARE_HISTORY

# Stop ambiguous completions (or similar events) from beeping, i.e. triggering a bell character event
unsetopt BEEP

autoload -U colors && colors
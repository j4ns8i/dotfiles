# Set command line editing mode to emacs
bindkey -e

export BASE=~/code
export EDITOR=nvim
export GOPATH=${BASE}
export GIT_PAGER='LESS= less -FRX'
export LESS=-R
export SRC=${BASE}/src
export TRACKS_DIR=${HOME}/scratch/tracks
# export PURE_PREPROMPT='%F{blue}%2~%f'
export WORDCHARS=${WORDCHARS/\/}
export PYENV_ROOT=~/.pyenv
export PYENV_VERSION=3.7.10

# Make ctrl-R full screen with fzf
export FZF_DEFAULT_OPTS='--height=100% --exact'

# Add new paths to $PATH if they dont already exist
function add_to_path() {
    [[ ${${(s.:.)PATH}[(i)${@}]} -gt ${#${(s.:.)PATH}} ]] && export PATH="${@}:${PATH}"
}

add_to_path "/usr/local/bin"
add_to_path "/usr/local/sbin"
add_to_path "$HOME/bin"
add_to_path "$GOPATH/bin"
add_to_path "${PYENV_ROOT}/bin"
add_to_path "${PYENV_ROOT}/shims"

command -v pyenv &>/dev/null && eval "$(pyenv init -)"

# macOS-specific aliases
if [[ "$(uname -s)" == "Darwin" ]]; then
    alias ls='gls --color' # coreutils homebrew package
    alias updatedb="sudo /usr/libexec/locate.updatedb"

    # from coreutils brew formula
    eval $(gdircolors)
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
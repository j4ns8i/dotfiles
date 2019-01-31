export BASE=~/code
export EDITOR=nvim
export GOPATH=${BASE}
export LESS=-R
export SRC=${BASE}/src
export TRACKS_DIR=${HOME}/scratch/tracks

# Add new paths to $PATH if they dont already exist
function add_to_path() {
    [[ ${${(s.:.)PATH}[(i)${@}]} -gt ${#${(s.:.)PATH}} ]] && export PATH="${@}:${PATH}"
}

add_to_path "/usr/local/bin"
add_to_path "/usr/local/sbin"
add_to_path "$HOME/.cargo/bin"  # Rust
add_to_path "$HOME/bin"
add_to_path "$GOPATH/bin"
add_to_path "/usr/local/opt/scala@2.11/bin"

# Make ctrl-R full screen with fzf
# export FZF_TMUX_HEIGHT=100%
export FZF_DEFAULT_OPTS='--height=100% --exact'

alias l='ls -AF'
alias ll='ls -AlhF'
alias llt='ls -thrAlF'
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias v2="source ${BASE}/venv2/bin/activate"
alias v3="source ${BASE}/venv3/bin/activate"
alias vim="nvim"
alias vimdiff="nvim -d"
alias view="nvim -R"
alias whats="dig +short"
alias evrc="vim ~/.vimrc"
alias elocal="vim ~/.config/zsh/local.zsh; source ~/.config/zsh/local.zsh"
alias vscode="open -a 'Visual Studio Code'"
alias sshmux="noglob sshmux.zsh"

# function vimgrep {
#     echo "\"${@[*]}\""
#     vim -c "silent grep \"${@[*]}\"" -c "cwindow"
# }

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
        for i in {30,37}; do
            for a in {40,47}; do
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
        done
    done
    echo ""
}

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
    cat /dev/urandom | gtr -dc 'a-zA-Z0-9' | head -c ${1:-8}
}

function git-me {
    if [[ -n "${1:#*/*}" ]]; then
        echo $'No "/" found, doesn\'t look like a repo to me' 1>&2
        return 1
    fi
    repo_owner="${1%/*}"
    repo_name="${1#*/}"
    mkdir -p "$SRC/github.com/${repo_owner}/${repo_name}"
    git -C "$SRC/github.com/${repo_owner}" clone "https://github.com/${repo_owner}/${repo_name}"
    cd "$SRC/github.com/${repo_owner}/${repo_name}"
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
export HISTCONTROL=ignoredups

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history

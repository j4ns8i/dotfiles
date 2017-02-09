export BASE=~/code
export EDITOR=vim
export GOPATH=${BASE}
export LESS=-R
export SRC=${BASE}/src

# Make ctrl-R full screen with fzf
# export FZF_TMUX_HEIGHT=100%
export FZF_DEFAULT_OPTS='--height=100% --exact'

alias ll='ls -AlhF'
alias venv3="source ${BASE}/venv3/bin/activate"
alias venv="source ${BASE}/venv/bin/activate"
alias vim="nvim"
alias myip="ifconfig en0"
alias vpnip="ifconfig utun1"

function ggo {
    # Go to a github organization
    MAX_DEPTH=2
    DIR=$(find $SRC -maxdepth $MAX_DEPTH -type d -name ${1});
    if [[ -d $DIR ]]; then
        cd $DIR;
    else
        echo "${1} could not be found under $SRC with a max depth of $MAX_DEPTH";
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
    fi
}

function galaxy-refresh {
    pushd -q ${SRC}/git.viasat.com/galaxy
    for x in $(ls); do
        echo "Repository: $x"
        git -C $x fetch origin --prune
        echo "\n"
    done
    popd -q
}

function show_colors {
    for x in 0 1 4 5 7 8; do
        for i in `seq 30 37`; do
            for a in `seq 40 47`; do
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
        done
    done
    echo ""
}

#########################
#
# History Configuration
#
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


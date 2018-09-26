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
    # Get/parse options
    # Just one option, -n/--new
    OPTS=$(gnu-getopt -o n -l new -n 'track-options' -- "$@")
    if [[ $? != 0 ]]; then
        echo "Failed parsing options" >&2
        return 1
    fi
    eval set -- "$OPTS"
    NEW_FILE=false
    while true; do
        case "$1" in
            -n | --new ) NEW_FILE=true; shift;;
            -- ) shift; break;;
            * ) break;;
        esac
    done

    FILE_NAME=${TRACKS_DIR}/${1}
    if $NEW_FILE; then
        # add date (and .md) to name of file
        FILE_NAME="${FILE_NAME}.$(date +%Y%m%d).md"
    fi
    vim $FILE_NAME
}

function alnum {
    cat /dev/urandom | gtr -dc 'a-zA-Z0-9' | head -c ${1:-8}
}

# function dns_cache {
#     local environments=( atg atgdev exede )
#     if [[ -n "${VIASAT_USERNAME}" && -n "${VIASAT_IO_PASSWORD}" ]]; then
#         typeset -agU dns_records

#         # get dns records for each environment specified
#         for env in $environments; do
#             local dns_mapping
#             local -aU records
#             dns_mapping=$(curl -f -s -u ${VIASAT_USERNAME}:${VIASAT_IO_PASSWORD} \
#                 https://api.us-or.viasat.io/api/v1/environments/${env}/dns/internal.json)

#             # if curl fails (auth) then exit before you lock your account
#             if [[ $? -ne 0 ]]; then return 1; fi

#             # grab just hostnames from the dns mapping
#             records=( $(echo $dns_mapping | jq -r '.[] | select(.type=="A") | .hostname' 2>/dev/null) )

#             # append $env's dns records to global array
#             set -A dns_records ${dns_records} ${records[@]}
#             unset dns_mapping records
#         done

#         echo "${dns_records[*]}" > ~/.cache/dns
#     else
#         echo "Must set VIASAT_USERNAME and VIASAT_IO_PASSWORD" >&2
#         return 1
#     fi
# }

# function sshmux {
#     if [[ "$1" == "" ]]; then
#         echo "Error: You must provide a hostname pattern" >&2
#         return 1
#     fi

#     read -A all_dns < ~/.cache/dns

#     local number_of_matches=${#${(M)all_dns:#${~1}}}

#     if [[ ${number_of_matches} -lt 1 ]]; then
#         echo "Error: No hostnames matched" >&2
#         return 1
#     elif [[ ${number_of_matches} -gt 10 ]]; then
#         echo "Error: Must only match 10 or fewer hostnames" >&2
#         echo "Selecting the first 10" >&2
#         osascript ~/bin/sshmux.applescript ${${(M)all_dns:#${~1}}[1,10]}
#     else
#         osascript ~/bin/sshmux.applescript ${(M)all_dns:#${~1}}
#     fi
# }

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

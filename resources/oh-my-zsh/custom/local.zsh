export BASE=~/code
export EDITOR=nvim
export GOPATH=${BASE}
export GIT_PAGER='less -FRX'
export NNN_RESTRICT_NAV_OPEN=1
# export LESS=-cFRX
export SRC=${BASE}/src
export TRACKS_DIR=${HOME}/scratch/tracks
# export RPROMPT="%F{red}${RANGER_LEVEL}%f%F{cyan}%t%f"
# export PURE_PREPROMPT='%F{blue}%2~%f'
export WORDCHARS=${WORDCHARS/\/}

# Make ctrl-R full screen with fzf
# export FZF_TMUX_HEIGHT=100%
export FZF_DEFAULT_OPTS='--height=100% --exact'
export FZF_CTRL_T_OPTS="--layout=reverse"

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

# for coreutils brew package on macOS - won't work on linux
alias ls='gls --color'
alias l='ls --color -AF'
alias ll='ls --color -AlhF'
alias llt='ls --color -thrAlF'
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias v2="source ${BASE}/venv2/bin/activate"
alias v3="source ${BASE}/venv3/bin/activate"
alias vim="nvim"
alias vimdiff="nvim -d"
alias view="nvim -R"
alias whats="dig +short"
alias evrc="vim ~/.vimrc"
alias elocal="vim ~/.config/zsh/runcommands/local.zsh; source ~/.config/zsh/runcommands/local.zsh"
alias vscode="open -a 'Visual Studio Code'"
alias sshmux="noglob sshmux"
alias k=kubectl
alias -g L="| less"

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
        for i in {30..37}; do
            for a in {40..47}; do
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
    # OPTS=$(gnu-getopt -o n -l new -n 'track-options' -- "$@")
    # if [[ $? != 0 ]]; then
    #     echo "Failed parsing options" >&2
    #     return 1
    # fi
    # eval set -- "$OPTS"
    # NEW_FILE=false
    # while true; do
    #     case "$1" in
    #         -n | --new ) NEW_FILE=true; shift;;
    #         -- ) shift; break;;
    #         * ) break;;
    #     esac
    # done
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

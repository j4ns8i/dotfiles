alias ls='gls --color' # coreutils homebrew package
alias docker-desktop-enter="docker run --rm -ti --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh"

# from coreutils brew formula
eval $(gdircolors)

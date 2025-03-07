alias g="git"
for git_alias in $(git config -l | grep '^alias\.' | cut -d. -f2 | cut -d= -f1); do
    alias g${git_alias}="git ${git_alias}"
done

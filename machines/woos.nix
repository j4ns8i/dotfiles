{
  imports =
    with builtins;
    map (filename: toString (../modules) + "/${filename}") (attrNames (readDir ../modules));

  j4ns8i = {
    graphicalApps = false;

    bat.enable = true;
    bun.enable = true;
    direnv.enable = true;
    fd.enable = true;
    fonts.enable = true;
    fzf.enable = true;
    ghostty.enable = true;
    git.enable = true;
    go.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    starship.enable = true;
    tmux.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };
}

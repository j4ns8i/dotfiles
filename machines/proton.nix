{
  imports =
    with builtins;
    map
      (filename: toString (../modules) + "/${filename}")
      (attrNames (readDir ../modules));

  j4ns8i = {
    graphicalApps = true;

    alacritty.enable = true;
    direnv.enable = true;
    firefox.enable = true;
    fonts.enable = true;
    fzf.enable = true;
    git.enable = true;
    neovim.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };
}

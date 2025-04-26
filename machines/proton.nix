{
  imports =
    with builtins;
    map
      (filename: toString (../modules) + "/${filename}")
      (attrNames (readDir ../modules));

  j4ns8i = {
    graphicalApps = true;

    alacritty.enable = false;
    direnv.enable = true;
    fd.enable = true;
    firefox.enable = true;
    fonts.enable = true;
    fzf.enable = true;
    ghostty.enable = true;
    git.enable = true;
    neovim.enable = true;
    tmux.enable = true;
    zsh.enable = true;
    bat.enable = true;
    zoxide.enable = true;
  };
}

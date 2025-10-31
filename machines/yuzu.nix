{
  imports =
    with builtins;
    map
      (filename: toString (../modules) + "/${filename}")
      (attrNames (readDir ../modules));

  j4ns8i = {
    graphicalApps = false;

    alacritty.enable = false;
    bun.enable = true;
    cursor.enable = false;
    direnv.enable = true;
    fd.enable = true;
    firefox.enable = true;
    fonts.enable = true;
    fzf.enable = true;
    ghostty.enable = true;
    git.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    tmux.enable = true;
    zsh.enable = true;
    starship.enable = true;
    bat.enable = true;
    zoxide.enable = true;
  };
}

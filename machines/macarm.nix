{
  imports =
    with builtins;
    map (filename: toString (../modules) + "/${filename}") (attrNames (readDir ../modules));

  j4ns8i = {
    graphicalApps = false;

    bat.enable = true;
    bun.enable = true;
    cursor.enable = true;
    direnv.enable = true;
    fd.enable = true;
    firefox.enable = true;
    fonts.enable = true;
    fzf.enable = true;
    ghostty.enable = true;
    git.enable = true;
    kubernetes.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    pure.enable = true;
    starship.enable = false;
    tmux.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };
}

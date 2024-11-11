{ pkgs, ... }: {
  imports =
    with builtins;
    map
      (filename: toString (../modules) + "/${filename}")
      (attrNames (readDir ../modules));

  j4ns8i = {
    alacritty.enable = true;
    direnv.enable = true;
    firefox.enable = false;
    fonts.enable = true;
    fzf.enable = true;
    git.enable = true;
    neovim.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };

  home.packages = with pkgs; [ coreutils ];
}

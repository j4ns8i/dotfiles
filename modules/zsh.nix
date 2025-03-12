{ config, lib, pkgs, ... }: {
  options.j4ns8i.zsh.enable = lib.mkEnableOption "zsh";
  config =
    let 
      zshrcExtra = ''
        ### BEGIN init from dotfiles/modules/zsh.nix ###
        export ZSH_CONFIG_DIR=~/.config/zsh
        source ''${ZSH_CONFIG_DIR}/init.zsh
        ### END init from dotfiles/modules/zsh.nix ###
      '';
    in lib.mkIf config.j4ns8i.zsh.enable {
      programs.zsh.enable = true;
      programs.zsh.initExtra = zshrcExtra;
      home.packages = with pkgs; [ zsh ];
      home.file = let
        symlink = config.lib.file.mkOutOfStoreSymlink;
        osZsh = if pkgs.stdenv.isDarwin then "darwin.zsh" else "nixos.zsh";
      in {
        ".config/zsh/pure".source = fetchGit {
          url = "https://github.com/sindresorhus/pure";
          rev = "a02209d36c8509c0e62f44324127632999c9c0cf";
        };
        ".config/zsh/share".source = symlink "${config.j4ns8i.hmDir}/config/zsh/share";
        ".config/zsh/local/os.zsh".source = symlink "${config.j4ns8i.hmDir}/config/zsh/${osZsh}";
        ".config/zsh/init.zsh".source = symlink "${config.j4ns8i.hmDir}/config/zsh/init.zsh";
      };
    };
}

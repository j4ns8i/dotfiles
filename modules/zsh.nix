{ config, lib, pkgs, ... }: {
  options.j4ns8i.zsh.enable = lib.mkEnableOption "zsh";
  config =
    let cfg = config.j4ns8i.zsh; in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ zsh ];
      home.file = let
        symlink = config.lib.file.mkOutOfStoreSymlink;
      in {
        ".config/zsh/pure".source = fetchGit {
          url = "https://github.com/sindresorhus/pure";
          rev = "a02209d36c8509c0e62f44324127632999c9c0cf";
        };
        ".zshrc".source = symlink "${config.j4ns8i.hmDir}/config/zsh/zshrc";
        ".config/zsh/share".source = symlink "${config.j4ns8i.hmDir}/config/zsh/share";
        ".config/zsh/os.zsh".source = symlink "${config.j4ns8i.hmDir}/config/zsh/nixos.zsh";
      };
    };
}

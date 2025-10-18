{ config, lib, pkgs, ... }: {
  options.j4ns8i.bun.enable = lib.mkEnableOption "bun";
  config =
    let cfg = config.j4ns8i.bun;
    in lib.mkIf cfg.enable {
      home.packages = with pkgs; [ bun ];
      home.file = let
        symlink = config.lib.file.mkOutOfStoreSymlink;
        hmDir = config.j4ns8i.hmDir;
      in {
        ".config/zsh/plugins/bun.zsh".source = symlink "${hmDir}/config/zsh/share/bun.zsh";
      };
    };
}

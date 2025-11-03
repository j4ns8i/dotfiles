{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.bun.enable = lib.mkEnableOption "bun";
  config =
    let
      cfg = config.j4ns8i.bun;
      hmDir = config.j4ns8i.hmDir;
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ bun ];
      home.file = {
        ".config/zsh/plugins/bun.zsh".source =
          config.lib.file.mkOutOfStoreSymlink "${hmDir}/config/bun/bun.zsh";
      };
    };
}

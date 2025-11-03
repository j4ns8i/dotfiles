{ config, lib, ... }:
{
  options.j4ns8i.direnv.enable = lib.mkEnableOption "direnv";
  config =
    let
      cfg = config.j4ns8i.direnv;
    in
    lib.mkIf cfg.enable {
      programs.direnv.enable = true;
      home.file = {
        ".config/direnv/direnvrc".source =
          config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/direnv/direnvrc";
      };
    };
}

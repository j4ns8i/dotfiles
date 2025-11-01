{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.fd.enable = lib.mkEnableOption "fd";
  config =
    let
      cfg = config.j4ns8i.fd;
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ fd ];
      home.file = {
        ".config/fd/ignore".source =
          config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/fd/ignore";
      };
    };
}

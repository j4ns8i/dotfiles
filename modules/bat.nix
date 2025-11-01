{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.bat.enable = lib.mkEnableOption "bat";
  config =
    let
      cfg = config.j4ns8i.bat;
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ bat ];
      home.file = {
        ".config/bat/config".source =
          config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/bat/config";
      };
    };
}

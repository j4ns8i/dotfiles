{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.go.enable = lib.mkEnableOption "go";
  config =
    let
      cfg = config.j4ns8i.go;
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ go ];
    };
}

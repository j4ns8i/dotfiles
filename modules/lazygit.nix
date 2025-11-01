{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.lazygit.enable = lib.mkEnableOption "lazygit";
  config =
    let
      cfg = config.j4ns8i.lazygit;
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ lazygit ];
    };
}

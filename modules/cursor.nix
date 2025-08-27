{ config, lib, pkgs, ... }: {
  options.j4ns8i.cursor.enable = lib.mkEnableOption "cursor";
  config =
    let cfg = config.j4ns8i.cursor;
    in lib.mkIf cfg.enable {
      home.packages = with pkgs; [ code-cursor ];
    };
}

{ config, lib, pkgs, ... }: {
  options.j4ns8i.ghostty.enable = lib.mkEnableOption "ghostty";
  config =
    let
      cfg = config.j4ns8i.ghostty;
      symlink = config.lib.file.mkOutOfStoreSymlink;
    in lib.mkIf cfg.enable {
      home.file.".config/ghostty".source = symlink "${config.j4ns8i.hmDir}/config/ghostty";
    };
}

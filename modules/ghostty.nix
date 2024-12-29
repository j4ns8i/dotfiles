{ config, lib, pkgs, ... }: {
  options.j4ns8i.ghostty.enable = lib.mkEnableOption "ghostty";
  config =
    let
      cfg = config.j4ns8i.ghostty;
      symlink = config.lib.file.mkOutOfStoreSymlink;
      osCfg = if pkgs.stdenv.isDarwin then "darwin.toml" else "nixos.toml";
    in lib.mkIf cfg.enable {
      home.file.".config/ghostty/config".source = symlink "${config.j4ns8i.hmDir}/config/ghostty/config";
      home.file.".config/ghostty/os.toml".source = symlink "${config.j4ns8i.hmDir}/config/ghostty/${osCfg}";
    };
}

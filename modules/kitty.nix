{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.kitty.enable = lib.mkEnableOption "kitty";
  config =
    let
      cfg = config.j4ns8i.kitty;
    in
    lib.mkIf cfg.enable {
      home.packages = lib.optional (config.j4ns8i.graphicalApps) pkgs.kitty;
      home.file = {
        ".config/kitty/kitty.conf".source =
          config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/kitty/kitty.conf";
        ".config/kitty/kitty-themes".source = fetchGit {
          url = "https://github.com/kovidgoyal/kitty-themes";
          rev = "1d379066fc44f58f4131421c31290bb8c82178d5";
        };
      };
    };
}

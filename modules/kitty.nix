{ config, lib, pkgs, ... }:
  let
    cfg = config.j4ns8i.kitty;
    symlink = config.lib.file.mkOutOfStoreSymlink;
  in {
    options.j4ns8i.kitty.enable = lib.mkEnableOption "kitty";
    config = lib.mkIf cfg.enable {
      home.packages = lib.optional (config.j4ns8i.graphicalApps) pkgs.kitty;
      home.file = {
        ".config/kitty/kitty.conf".source = symlink "${config.j4ns8i.hmDir}/config/kitty/kitty.conf";
        ".config/kitty/kitty-themes".source = fetchGit {
          url = "https://github.com/kovidgoyal/kitty-themes";
          rev = "1d379066fc44f58f4131421c31290bb8c82178d5";
        };
      };
    };
  }

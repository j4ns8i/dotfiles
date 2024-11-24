{ config, lib, pkgs, ... }:
  let
    cfg = config.j4ns8i.alacritty;
    symlink = config.lib.file.mkOutOfStoreSymlink;
    osToml = if pkgs.stdenv.isDarwin then "darwin.toml" else "nixos.toml";
  in {
    options.j4ns8i.alacritty.enable = lib.mkEnableOption "alacritty";
    config = lib.mkIf cfg.enable {
      home.packages = lib.optional (config.j4ns8i.graphicalApps) pkgs.alacritty;
      home.file = {
        ".config/alacritty/alacritty.toml".source = symlink "${config.j4ns8i.hmDir}/config/alacritty/alacritty.toml";
        ".config/alacritty/colors.toml".source = symlink "${config.j4ns8i.hmDir}/config/alacritty/colors.toml";
        ".config/alacritty/os.toml".source = symlink "${config.j4ns8i.hmDir}/config/alacritty/${osToml}";
        ".config/alacritty/themes".source = fetchGit {
          url = "https://github.com/alacritty/alacritty-theme";
          rev = "09c3fb391ff40fedb3f167b3256cbe9255af131e";
        };
        ".config/alacritty/base16-themes".source = fetchGit {
          url = "https://github.com/aarowill/base16-alacritty";
          rev = "c95c200b3af739708455a03b5d185d3d2d263c6e";
        };
      };
    };
  }

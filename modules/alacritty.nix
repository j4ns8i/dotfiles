{ config, lib, pkgs, ... }: {
  options.j4ns8i.alacritty.enable = lib.mkEnableOption "alacritty";
  config =
    let cfg = config.j4ns8i.alacritty; in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ alacritty ];
      home.file = let
        hmDirectory = "${config.home.homeDirectory}/.config/home-manager";
        symlink = config.lib.file.mkOutOfStoreSymlink;
      in {
        ".config/alacritty/alacritty.toml".source = symlink "${hmDirectory}/config/alacritty/alacritty.toml";
        ".config/alacritty/colors.toml".source = symlink "${hmDirectory}/config/alacritty/colors.toml";
        ".config/alacritty/os.toml".source = symlink "${hmDirectory}/config/alacritty/nixos.toml";
        ".config/alacritty/themes".source = fetchGit {
          url = "https://github.com/alacritty/alacritty-theme";
          rev = "09c3fb391ff40fedb3f167b3256cbe9255af131e";
        };
      };
    };
}

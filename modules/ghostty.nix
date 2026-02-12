{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.ghostty.enable = lib.mkEnableOption "ghostty";
  config =
    let
      cfg = config.j4ns8i.ghostty;
      osToml = if pkgs.stdenv.isDarwin then "darwin.toml" else "nixos.toml";
    in
    lib.mkIf cfg.enable {
      home.file.".config/ghostty/config".source =
        config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/ghostty/config";
      home.file.".config/ghostty/os.toml".source =
        config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/ghostty/${osToml}";
      home.file.".config/ghostty/themes/catppuccin".source = fetchGit {
        url = "https://github.com/catppuccin/ghostty";
        rev = "9e38fc2b4e76d4ed5ff9edc5ac9e4081c7ce6ba6";
      };
      home.file.".config/ghostty/themes/catppuccin-mocha".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/ghostty/themes/catppuccin/themes/catppuccin-mocha.conf";
      home.file.".config/ghostty/themes/black-metal-nile".source =
        config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/ghostty/black-metal-nile";
    };
}

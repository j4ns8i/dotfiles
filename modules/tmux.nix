{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.tmux.enable = lib.mkEnableOption "tmux";
  config =
    let
      cfg = config.j4ns8i.tmux;
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ tmux ];
      home.file =
        let
          symlink = config.lib.file.mkOutOfStoreSymlink;
          osConf = if pkgs.stdenv.isDarwin then "darwin.conf" else "nixos.conf";
        in
        {
          ".config/tmux/tmux.conf".source = symlink "${config.j4ns8i.hmDir}/config/tmux/tmux.conf";
          ".config/tmux/os.conf".source = symlink "${config.j4ns8i.hmDir}/config/tmux/${osConf}";
          ".config/tmux/vim-tmux-navigator.conf".source =
            symlink "${config.j4ns8i.hmDir}/config/tmux/vim-tmux-navigator.conf";
          ".config/tmux/themes".source = fetchGit {
            url = "https://github.com/tinted-theming/tinted-tmux";
            rev = "20396f130e477512632c37f72590b71f59dbef88";
          };
        };
    };
}

{ config, lib, pkgs, ... }: {
  options.j4ns8i.tmux.enable = lib.mkEnableOption "tmux";
  config =
    let cfg = config.j4ns8i.tmux; in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ tmux ];
      home.file = let
        symlink = config.lib.file.mkOutOfStoreSymlink;
      in {
        ".tmux.conf".source = symlink "${config.j4ns8i.hmDir}/config/tmux/tmux.conf";
        ".config/tmux/os.conf".source = symlink "${config.j4ns8i.hmDir}/config/tmux/nixos.conf";
        ".config/tmux/vim-tmux-navigator.conf".source = symlink "${config.j4ns8i.hmDir}/config/tmux/vim-tmux-navigator.conf";
      };
    };
}

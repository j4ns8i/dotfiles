{ config, lib, pkgs, ... }: {
  options.j4ns8i.neovim.enable = lib.mkEnableOption "neovim";
  config =
    let cfg = config.j4ns8i.neovim; in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ neovim ];
      home.file = let
        hmDirectory = "${config.home.homeDirectory}/.config/home-manager";
        symlink = config.lib.file.mkOutOfStoreSymlink;
      in {
        ".config/nvim".source = symlink "${hmDirectory}/roles/neovim/links/config/nvim";
      };
    };
}

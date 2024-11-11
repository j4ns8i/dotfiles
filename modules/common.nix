{ config, lib, pkgs, ... }: {
  options.j4ns8i.hmDir = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/.config/home-manager";
  };

  config = {
    home.username = "j4ns8i";
    home.homeDirectory = "/home/j4ns8i";

    home.packages = with pkgs; [
      # utilities
      gnumake
      zlib
      gcc
      bat
      fontconfig
      gomplate
      htop
      jq
      ripgrep
      tree
      unzip
      zoxide
      xdg-utils
      file

      # programming languages
      rustup
      go
      nodejs_22
      pnpm_9
      nodePackages.neovim
      lua-language-server

      # graphical apps
      kitty
      wezterm
      obsidian
      discord
      slack
      spotify
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.
  };
}

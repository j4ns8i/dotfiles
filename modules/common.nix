{ config, lib, pkgs, setupCfg, ... }: {
  options.j4ns8i = {
    hmDir = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.config/home-manager";
    };

    graphicalApps = lib.mkEnableOption "Install graphical apps";
  };

  config = {
    home.username = setupCfg.username or "j4ns8i";
    home.homeDirectory = setupCfg.homeDirectory or "/home/j4ns8i";

    home.packages = with pkgs; [

      # utilities
      gnumake
      zlib
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
      devenv
      delta

      # programming languages
      rustup
      go
      nodejs_22
      pnpm_9
      lua-language-server

    ] ++ lib.optionals config.j4ns8i.graphicalApps [
      discord
      obsidian
      slack
      spotify
      wezterm
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

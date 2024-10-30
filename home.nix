{ config, pkgs, ... }:

let
  hmDirectory = "${config.home.homeDirectory}/.config/home-manager";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "j4ns8i";
  home.homeDirectory = "/home/j4ns8i";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    gnumake
    zlib
    gcc
    zsh
    bat
    fontconfig
    fzf
    git
    gomplate
    htop
    jq
    neovim
    ripgrep
    tmux
    tree
    unzip
    zoxide

    # graphical apps (that aren't configured explicitly below)
    kitty
    alacritty
    wezterm
    obsidian
    spotify

    # fonts
    jetbrains-mono
    noto-fonts-emoji

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = let
    symlink = config.lib.file.mkOutOfStoreSymlink;
  in {
    # git
    ".config/git/config".source = symlink "${hmDirectory}/roles/bootstrap/links/gitconfig";

    # tmux
    ".tmux.conf".source = symlink "${hmDirectory}/roles/tmux/links/tmux.conf";
    ".config/tmux/os.conf".source = symlink "${hmDirectory}/roles/tmux/links/nixos.conf";
    ".config/tmux/vim-tmux-navigator.conf".source = symlink "${hmDirectory}/roles/tmux/links/vim-tmux-navigator.conf";

    # alacritty
    ".config/alacritty/alacritty.toml".source = symlink "${hmDirectory}/roles/alacritty/links/alacritty.toml";
    ".config/alacritty/colors.toml".source = symlink "${hmDirectory}/roles/alacritty/links/colors.toml";
    ".config/alacritty/os.toml".text = ''
      [shell]
      args = ["-l"]
      program = "${pkgs.tmux.out}/bin/tmux"

      [window]
      decorations = "None"
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/j4ns8i/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Customized configuration below

  fonts.fontconfig = {
    enable = true;
    defaultFonts.emoji = [
      "Noto Color Emoji"
    ];
    defaultFonts.monospace = [
      "JetBrains Mono"
      "Noto Color Emoji"
    ];
  };

  programs.firefox = {
    enable = true;
    policies = {
      Preferences = {
	"general.autoScroll" = true;
      };
    };
  };
}

# vim: set sw=2 :

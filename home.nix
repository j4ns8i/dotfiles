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
    xdg-utils
    file

    # programming languages
    rustup
    go
    nodejs_22
    pnpm_9
    nodePackages.neovim
    lua-language-server

    # graphical apps (that aren't configured explicitly below)
    kitty
    alacritty
    wezterm
    obsidian
    discord
    slack
    spotify

    # fonts
    noto-fonts-emoji

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

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
    ".config/alacritty/os.toml".source = symlink "${hmDirectory}/roles/alacritty/links/nixos.toml";
    ".config/alacritty/themes".source = fetchGit {
      url = "https://github.com/alacritty/alacritty-theme";
      rev = "09c3fb391ff40fedb3f167b3256cbe9255af131e";
    };

    # zsh
    ".config/zsh/pure".source = fetchGit {
      url = "https://github.com/sindresorhus/pure";
      rev = "a02209d36c8509c0e62f44324127632999c9c0cf";
    };
    ".zshrc".source = symlink "${hmDirectory}/roles/zsh/links/zshrc";
    ".config/zsh/share".source = symlink "${hmDirectory}/roles/zsh/links/share";
    ".config/zsh/os.zsh".source = symlink "${hmDirectory}/roles/zsh/links/nixos.zsh";

    # direnv
    ".config/direnv/direnvrc".source = symlink "${hmDirectory}/roles/direnv/links/direnvrc";

    # neovim
    ".config/nvim".source = symlink "${hmDirectory}/roles/neovim/links/config/nvim";
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

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
        "app.shield.optoutstudies.enabled" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "signon.rememberSignons" = false;
      };
      # See https://mozilla.github.io/policy-templates/#extensionsettings for format.
      # TL;DR to get key, curl https://addons.mozilla.org/api/v5/addons/addon/<slug> | jq .guid
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "addon@darkreader.org" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
      };
    };
  };
}

# vim: set sw=2 :
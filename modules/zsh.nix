{
  config,
  lib,
  pkgs,
  setupCfg,
  ...
}:
{
  options.j4ns8i.zsh.enable = lib.mkEnableOption "zsh";
  config =
    let
      zshrcExtra = ''
        ### BEGIN init from dotfiles/modules/zsh.nix ###
        export ZSH_CONFIG_DIR=~/.config/zsh
        source ''${ZSH_CONFIG_DIR}/init.zsh
        ### END init from dotfiles/modules/zsh.nix ###
      '';
      symlink = config.lib.file.mkOutOfStoreSymlink;
      osZsh = if pkgs.stdenv.isDarwin then "darwin.zsh" else "nixos.zsh";
      hmDir = config.j4ns8i.hmDir;
      machineZsh = "${hmDir}/config/zsh/${setupCfg.hostName}.zsh";
    in
    lib.mkIf config.j4ns8i.zsh.enable {
      programs.zsh = {
        enable = true;
        initContent = zshrcExtra;
      };
      home.packages = with pkgs; [ zsh ];
      home.file = {
        ".config/zsh/pure".source = fetchGit {
          url = "https://github.com/sindresorhus/pure";
          rev = "a02209d36c8509c0e62f44324127632999c9c0cf";
        };
        ".config/zsh/share".source = symlink "${hmDir}/config/zsh/share";
        ".config/zsh/local/os.zsh".source = symlink "${hmDir}/config/zsh/${osZsh}";
        ".config/zsh/init.zsh".source = symlink "${hmDir}/config/zsh/init.zsh";
        ".config/zsh/local/machine.zsh".source = symlink "${machineZsh}";
      };
    };
}

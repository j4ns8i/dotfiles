{ config, lib, ... }:
{
  options.dotfiles.home-manager.pure = {
    enable = lib.mkEnableOption "pure";
  };

  config =
    let
      cfg = config.dotfiles.home-manager.pure;
      symlink =
        path: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.general.root}/${path}";
    in
    lib.mkIf cfg.enable {
      home.file = {
        ".config/zsh/plugins/pure".source = fetchGit {
          url = "https://github.com/sindresorhus/pure";
          rev = "a075119689fb164a7501624b21936f74e533c6eb";
        };
        ".config/zsh/plugins/pure.zsh".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.general.root}/config/pure/pure.zsh";
      };
    };
}

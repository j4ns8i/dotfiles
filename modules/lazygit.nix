{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.lazygit.enable = lib.mkEnableOption "lazygit";
  config =
    let
      cfg = config.j4ns8i.lazygit;
      symlink = path: config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/${path}";
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ lazygit ];
      home.file = {
        ".config/zsh/plugins/lazygit.zsh".source = symlink "config/lazygit/lazygit.zsh";
      };
    };
}

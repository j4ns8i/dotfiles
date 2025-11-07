{ config, lib, ... }:
{
  options.j4ns8i.pure.enable = lib.mkEnableOption "pure";
  config =
    let
      cfg = config.j4ns8i.pure;
      symlink = path: config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/${path}";
    in
    lib.mkIf cfg.enable {
      # TODO: move pure clone step from zsh to this module
      home.file = {
        ".config/zsh/plugins/pure.zsh".source = symlink "config/pure/pure.zsh";
      };
    };
}

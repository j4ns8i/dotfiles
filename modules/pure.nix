{ config, lib, ... }:
{
  options.j4ns8i.pure.enable = lib.mkEnableOption "pure";
  config =
    let
      cfg = config.j4ns8i.pure;
      symlink = path: config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/${path}";
    in
    lib.mkIf cfg.enable {
      home.file = {
        ".config/zsh/plugins/pure".source = fetchGit {
          url = "https://github.com/sindresorhus/pure";
          rev = "dbefd0dcafaa3ac7d7222ca50890d9d0c97f7ca2";
        };
        ".config/zsh/plugins/pure.zsh".source = symlink "config/pure/pure.zsh";
      };
    };
}

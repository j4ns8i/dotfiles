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
          rev = "58fe1ac501df94f5458b8c7d08fbea8e5bd86426";
        };
        ".config/zsh/plugins/pure.zsh".source = symlink "config/pure/pure.zsh";
      };
    };
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.git.enable = lib.mkEnableOption "git";
  config =
    let
      cfg = config.j4ns8i.git;
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [ git ];
      home.file = {
        ".config/git/config".source =
          config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/git/gitconfig";
      };
    };
}

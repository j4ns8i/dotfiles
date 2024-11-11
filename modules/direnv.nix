{ config, lib, ... }: {
  options.j4ns8i.direnv.enable = lib.mkEnableOption "direnv";
  config =
    let cfg = config.j4ns8i.direnv; in
    lib.mkIf cfg.enable {
      programs.direnv.enable = true;
      home.file = let
        symlink = config.lib.file.mkOutOfStoreSymlink;
      in {
        ".config/direnv/direnvrc".source = symlink "${config.j4ns8i.hmDir}/config/direnv/direnvrc";
      };
    };
}

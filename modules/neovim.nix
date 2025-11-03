{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.neovim.enable = lib.mkEnableOption "neovim";
  config =
    let
      cfg = config.j4ns8i.neovim;
    in
    lib.mkIf cfg.enable {
      home.file = {
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/neovim";
      };
      home.packages = with pkgs; [
        helm-ls
      ];
      programs.neovim = {
        enable = true;
        withNodeJs = true;
        withPython3 = true;
      };
    };
}

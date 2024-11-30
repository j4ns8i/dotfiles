{ config, lib, pkgs, ... }: {
  options.j4ns8i.neovim.enable = lib.mkEnableOption "neovim";
  config =
    let cfg = config.j4ns8i.neovim; in
    lib.mkIf cfg.enable {
      home.file = let
        symlink = config.lib.file.mkOutOfStoreSymlink;
      in {
        ".config/nvim".source = symlink "${config.j4ns8i.hmDir}/config/neovim";
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

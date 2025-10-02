{ config, lib, pkgs, ... }: {
  options.j4ns8i.starship.enable = lib.mkEnableOption "starship";
  config =
    let cfg = config.j4ns8i.starship;
    in lib.mkIf cfg.enable {
      home.packages = with pkgs; [ starship ];
      home.file = {
        ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/starship/starship.toml";
        ".config/zsh/plugins/starship.zsh".source = config.lib.file.mkOutOfStoreSymlink "${config.j4ns8i.hmDir}/config/starship/starship.zsh";
      };
    };
}

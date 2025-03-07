{ config, lib, ... }: {
  options.j4ns8i.fzf.enable = lib.mkEnableOption "fzf";
  config =
    let cfg = config.j4ns8i.fzf; in
    lib.mkIf cfg.enable {
      programs.fzf = {
        enable = true;
        enableZshIntegration = config.programs.zsh.enable;
      };
    };
}

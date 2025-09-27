{ config, lib, ... }: {
  options.j4ns8i.zoxide.enable = lib.mkEnableOption "zoxide";
  config =
    let cfg = config.j4ns8i.zoxide; in
    lib.mkIf cfg.enable {
      programs.zoxide = {
        enable = true;
      };
    };
}

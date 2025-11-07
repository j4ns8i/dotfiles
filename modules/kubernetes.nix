{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.j4ns8i.kubernetes.enable = lib.mkEnableOption "Kubernetes tools";

  config =
    let
      cfg = config.j4ns8i.kubernetes;
    in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        stern
        kubectx
        kubectl
        k3d
      ];
    };
}

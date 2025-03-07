{ config, lib, pkgs, ... }: {
  options.j4ns8i.fonts.enable = lib.mkEnableOption "fonts";
  config =
    let cfg = config.j4ns8i.fonts; in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        noto-fonts-emoji
        jetbrains-mono
        geist-font
        roboto-mono
      ];
      fonts.fontconfig = {
        enable = true;
        defaultFonts.emoji = [
          "Noto Color Emoji"
        ];
        defaultFonts.monospace = [
          "JetBrains Mono"
          "Geist Mono"
          "Roboto Mono"
          "Noto Color Emoji"
        ];
      };
    };
}

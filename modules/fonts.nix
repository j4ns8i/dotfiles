{ config, lib, pkgs, ... }: {
  options.j4ns8i.fonts.enable = lib.mkEnableOption "fonts";
  config =
    let cfg = config.j4ns8i.fonts; in
    lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        noto-fonts-emoji
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];
      fonts.fontconfig = {
        enable = true;
        defaultFonts.emoji = [
          "Noto Color Emoji"
        ];
        defaultFonts.monospace = [
          "JetBrains Mono"
          "Noto Color Emoji"
        ];
      };
    };
}

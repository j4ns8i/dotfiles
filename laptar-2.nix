{ config, ...}: {
  home.file."asdf".text = config.laptar.asdfText or "none found";
}

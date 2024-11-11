{
  description = "Home Manager configuration of j4ns8i";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = name: cfg: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = cfg.system or "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = cfg.modules;
      };
      hosts = {
        "j4ns8i@laptar-2" = {
          modules = [ ./machines/laptar.nix ];
        };
        "j4ns8i@proton-3" = {
          modules = [ ./machines/proton.nix ];
        };
      };
    in {
      homeConfigurations = nixpkgs.lib.mapAttrs mkHome hosts;
    };
}

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
      commonModules = [
        ./home.nix
      ];
      mkHome = name: cfg: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = cfg.system or "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = commonModules ++ (cfg.modules or []);
      };
      hosts = {
        "j4ns8i@laptar-2" = {
          config.laptar.asdfText = "hello world";
          modules = [
            ./laptar-2.nix
          ];
        };
      };
    in {
      homeConfigurations = nixpkgs.lib.mapAttrs mkHome hosts;
    };
}

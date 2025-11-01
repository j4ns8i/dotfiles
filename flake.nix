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

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      mkHome =
        name: cfg:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = cfg.system or "x86_64-linux";
            config.allowUnfree = true;
          };
          inherit (cfg) modules;
          extraSpecialArgs.setupCfg = (cfg.setupCfg or { }) // {
            hostName = nixpkgs.lib.last (nixpkgs.lib.splitString "@" name);
          };
        };
      setups = {
        "j4ns8i@laptar-2" = {
          modules = [ ./machines/laptar.nix ];
        };
        "j4ns8i@proton-3" = {
          modules = [ ./machines/proton.nix ];
        };
        "j4ns8i@woos" = {
          modules = [ ./machines/woos.nix ];
        };
        "justin.smalkowski@justin.smalkowski-YJ0VNX32G2" = {
          modules = [ ./machines/macarm.nix ];
          system = "aarch64-darwin";
          setupCfg = {
            username = "justin.smalkowski";
            homeDirectory = "/Users/justin.smalkowski";
          };
        };
        "justinsmalkowski@yuzu" = {
          modules = [ ./machines/yuzu.nix ];
          system = "aarch64-darwin";
          setupCfg = {
            username = "justinsmalkowski";
            homeDirectory = "/Users/justinsmalkowski";
          };
        };
      };
    in
    {
      homeConfigurations = nixpkgs.lib.mapAttrs mkHome setups;
    };
}
# vim: sw=2 ts=2 sts=2 et ai

{
  description = "Home Manager configuration of j4ns8i";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      utils,
      ...
    }:
    let
      mkHome =
        name: cfg:
        let
          hostName = nixpkgs.lib.last (nixpkgs.lib.splitString "@" name);
          setupCfg = (cfg.setupCfg or { }) // {
            inherit hostName;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = cfg.system or "x86_64-linux";
            config.allowUnfree = true;
          };
          inherit (cfg) modules;
          extraSpecialArgs.setupCfg = setupCfg;
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
    }
    // utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            bun
            go-task
            fd
          ];
          shellHook = ''
            bun husky
          '';
        };
      }
    );
}
# vim: sw=2 ts=2 sts=2 et ai

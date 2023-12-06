{

    description = "Nix configuration as a flake for trinsic and ankh. Using trinsic as day to day and ankh as testing";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};

        in {
            nixosConfigurations = {
                ankh = lib.nixosSystem{
                    inherit system;
                    modules = [ ./configuration.nix ];
                };
                trinsic = lib.nixosSystem{
                    inherit system;
                    modules = [ ./configuration-trinsic.nix ];
                };
            };
            homeConfigurations = {
                ankh = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home.nix ];
                };
                trinsic = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home-trinsic.nix ];
                };
            };
        };

}

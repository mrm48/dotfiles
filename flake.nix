{

    description = "Nix configuration as a flake for trinsic and ankh. Using trinsic as day to day and ankh as testing";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            nixosConfigurations = {
                cove = lib.nixosSystem{
                    inherit system;
                    modules = [ ./cove/configuration.nix ./configuration.nix ];
                };
                ankh = lib.nixosSystem{
                    inherit system;
                    modules = [ ./ankh/configuration.nix ./configuration.nix ];
                };
                trinsic = lib.nixosSystem{
                    inherit system;
                    modules = [ ./trinsic/configuration.nix ./configuration.nix ];
                };
                moonstone = lib.nixosSystem{
                    inherit system;
                    modules = [ ./moonstone/configuration.nix ./configuration.nix ];
                };
            };
	        home-manager = {
	    	    useUserPackages = true;
	        };
            homeConfigurations = {
                cove = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home.nix ./cove/home.nix ];
                }
                ankh = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home.nix ./ankh/home.nix ];
                };
                trinsic = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home.nix ./trinsic/home.nix ];
                };
                moonstone = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home.nix ./moonstone/home.nix ];
                };
            };
        };

}

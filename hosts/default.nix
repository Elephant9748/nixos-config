{ lib, vars, inputs, nixpkgs-unstable, home-manager,  ... }:
let
    system = "x86_64-linux";

    unstable = import nixpkgs-unstable {
        inherit system;
	config.allowUnfree = true;
    };

    lib = nixpkgs-unstable.lib;
in
{
    rachel = lib.nixosSystem {
	specialArgs = {
            inherit inputs system unstable vars;
	    host = {
	        hostname = "nixos-phoebe";
	    };
	};
	modules = [
	    # nixvim.nixosModules.nixvim
	    ./rachel
	    ./configuration.nix

	    home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.users.rachel.imports = [
                    ./rachel/home.nix
                    # nixvim.homeManagerModules.nixvim
                ];
	    }
	];
    };
}

# Structur directory
# -----------------------------------------------
# ├── flake.lock
# ├── flake.nix
# ├── hosts
# │   ├── configuration.nix
# │   ├── default.nix
# │   └── rachel
# │       ├── default.nix
# │       ├── hardware-configuration.nix
# │       └── home.nix
# ├── modules
# │   ├── dotfiles
# │   └── editors
# │       ├── default.nix
# │       └── nvim.nix
# ├── README.md
# └── theming
#     └── colors.nix
# -----------------------------------------------

{ lib, vars, inputs, nixpkgs-unstable, home-manager, hyprland,  ... }:
let
    system = "x86_64-linux";

    unstable = import nixpkgs-unstable {
        inherit system;
	    config.allowUnfree = true;
    };

    lib = nixpkgs-unstable.lib;
in
{
    # no GUI
    rigel  = lib.nixosSystem {
	    specialArgs = {
                inherit inputs system unstable vars;
	        host = {
	            hostname = "nixos-io";
	        };
	    };
	    modules = [
	        # nixvim.nixosModules.nixvim
            hyprland.nixosModules.default
	        ./rigel
	        ./configuration.nix

	        home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
	    	    home-manager.useUserPackages = true;
	    	    home-manager.users.rachel.imports = [
                    ./rigel/home.nix
                    # nixvim.homeManagerModules.nixvim
                ];
	        }
	    ];
    };

    # with desktop
    rachel = lib.nixosSystem {
	    specialArgs = {
                inherit inputs system unstable vars;
	        host = {
	            hostname = "nixos-phoebe";
	        };
	    };
	    modules = [
	        # nixvim.nixosModules.nixvim
            hyprland.nixosModules.default
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

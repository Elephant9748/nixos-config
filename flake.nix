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

{
  description = "Nixos Rachel Flake";

  inputs = {
	# nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
	nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";	

	home-manager = {                                                  
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

	# nixvim = {                                              # Neovim
	#     url = "github:nix-community/nixvim";
	#     inputs.nixpkgs.follows = "nixpkgs-unstable";
	# };
    hyprland = {
        url = "github:hyprwm/Hyprland";
        # build with your own instance of nixpkgs
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };


  };

  outputs = inputs @ { self, home-manager, nixpkgs-unstable, hyprland }: 
    let
        vars = { 
        user = "rachel";
        version = "24.05";
        editor = "nvim";
    };
    in
    {
      nixosConfigurations = (
        import ./hosts {
            inherit (nixpkgs-unstable) lib;
            inherit inputs nixpkgs-unstable home-manager hyprland vars;
        }
      );
    };
}

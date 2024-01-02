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


  };

  outputs = inputs @ { self, home-manager, nixpkgs-unstable }: 
      let
          vars = { 
	      user = "rachel";
	      version = "24.05";
	      location = "$HOME/.setup";
	      editor = "nvim";
	  };
      in
      {
          nixosConfigurations = (
	      import ./hosts {
	          inherit (nixpkgs-unstable) lib;
		  inherit inputs nixpkgs-unstable home-manager vars;
	      }
	  );
      };
}

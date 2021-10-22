{
  description = "My Awesome System Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    dwm = {
        url = "github:jadecell/dwm";
        inputs.nixpkgs.follows = "nixpkgs";
        flake = false;
    };

    nur = {
        url = "github:nix-community/NUR";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
        url = "github:nix-community/neovim-nightly-overlay";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, dwm, nur, neovim-nightly-overlay, ... }:
  let
    system = "x86_64-linux";
    
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;
 
  in {
    nixosConfigurations = {
      orion = lib.nixosSystem {
	inherit system;
	
	modules = [
	  ./configuration.nix
          home-manager.nixosModules.home-manager {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.users.jackson = import ./config/home.nix;
           nixpkgs.overlays = [ 

	     # Dwm
	     (final: prev: {
		   dwm = prev.dwm.overrideAttrs (o: {
	           src = dwm;
		   });
             })

             # Neovim nightly  
             nur.overlay neovim-nightly-overlay.overlay 

           ];
	  }
	];
      };
    };
  };
}

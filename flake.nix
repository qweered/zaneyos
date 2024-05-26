{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
    turtle-git = {
      url = "git+https://gitlab.gnome.org/philippun1/turtle";
      flake = false;
    };
    matugen.url = "github:InioX/matugen?ref=v2.2.0"; #FIXME: broken in main
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";

    # very unpopular fork
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{nixpkgs, spicetify-nix, home-manager, impermanence, ... }:
  let
    system = "x86_64-linux";
    host = "hyprnix";
    inherit (import ./hosts/${host}/options.nix) username hostname;

    pkgs = import nixpkgs {
      inherit system;
      config = {
	    allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
	specialArgs = { 
          inherit system; inherit inputs; 
          inherit username; inherit hostname;
          inherit host;
        };
	modules = [ 
	  ./system.nix
	  spicetify-nix.nixosModules.default
	  impermanence.nixosModules.impermanence
      home-manager.nixosModules.home-manager {
	    home-manager.extraSpecialArgs = {
              inherit username; inherit inputs;
              inherit host;
        };
	    home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
	    home-manager.users.${username} = import ./users/home.nix;
	  }
	];
    };
    };
  };
}

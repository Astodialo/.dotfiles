{
 
  description = "Elamon flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ...}@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix
            stylix.nixosModules.stylix ];
        };
      };
      homeConfigurations = {
        delos = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          #modules = [ ./home/wm/hyprland/home.nix ];
          modules = [ ./home/wm/xmonad/home.nix 
                    ];
        };
      };
    };

}

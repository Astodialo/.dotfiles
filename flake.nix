{
 
  description = "Elamon flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, rust-overlay, ...}@inputs:
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
            stylix.nixosModules.stylix 
            ({ pkgs, ...}: {
               nixpkgs.overlays = [rust-overlay.overlays.default ];
               environment.systemPackages = [pkgs.rust-bin.stable.latest.default ];
            })
          ];
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

{
  description = "Delos's Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ...}:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        delos = lib.nixosSystem {
          system = "x86_64-linux";
	  modules = [
            ./configuration.nix
            ./lsp.nix
          ];
	};
      };
    };

}

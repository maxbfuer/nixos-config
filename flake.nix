{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwl-flake = {
      url = "github:maxbfuer/dwl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    dwl-flake,
    ...
  } @ inputs: {
    nixosConfigurations.gaia = let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
      nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.max = import ./home.nix;
          }
          {
            environment.systemPackages = [
              dwl-flake.packages.x86_64-linux.dwl
            ];
          }
        ];
      };
  };
}

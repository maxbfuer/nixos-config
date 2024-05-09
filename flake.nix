{
  description = "My NixOS config";

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
  } @ inputs: let
    system = "x86_64-linux";
  in {
    # define the formatter used by `nix fmt`
    formatter = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations = {
      gaia = nixpkgs.lib.nixosSystem {
        # pass inputs as args to all submodules
        specialArgs = {inherit inputs;};
        modules = [
          # system-wide config
          ./system

          # home config
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.max = import ./home;
            };
          }
        ];
      };
    };
  };
}

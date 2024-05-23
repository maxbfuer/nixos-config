{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dwl-flake = {
      url = "github:maxbfuer/dwl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {
    self,
    nixpkgs,
    stable-nixpkgs,
    home-manager,
    dwl-flake,
    impermanence,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    # define the formatter used by `nix fmt`
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

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
              extraSpecialArgs = {inherit inputs;};
              useUserPackages = true;
              useGlobalPkgs = true;
              users.max = import ./home;
            };
          }
          impermanence.nixosModules.impermanence
        ];
      };
    };
  };
}

{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable-nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # impermanence.url = "github:nix-community/impermanence";
    # using the unmerged PR with defaultDirectoryMethod for the impermanence home-manager module
    impermanence.url = "github:Misterio77/impermanence/65a12c0542b18fa380c18364c6091088ec09f29b";

    dwl-flake = {
      url = "github:maxbfuer/dwl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
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
        specialArgs = {inherit inputs system;};
        modules = [
          ./nixosModules
          ./hosts/gaia/configuration.nix

          # home config
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs system;};
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

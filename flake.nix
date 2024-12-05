{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # impermanence.url = "github:nix-community/impermanence";
    # using the unmerged PR with defaultDirectoryMethod for the impermanence home-manager module
    impermanence.url = "github:Misterio77/impermanence/65a12c0542b18fa380c18364c6091088ec09f29b";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # dwl-flake = {
    #   url = "github:maxbfuer/dwl";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    impermanence,
    nix-vscode-extensions,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    # define the formatter used by `nix fmt`
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations = {
      gaia = nixpkgs.lib.nixosSystem {
        # pass inputs as args to all submodules
        specialArgs = {inherit inputs system pkgs-unstable nix-vscode-extensions;};
        modules = [
          ./nixosModules/importer.nix
          ./hosts/gaia/configuration.nix
          ./home-manager.nix

          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
        ];
      };
    };
  };
}

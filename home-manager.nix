{
  inputs,
  system,
  pkgs-unstable,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {inherit inputs system pkgs-unstable;};

    useUserPackages = true;
    useGlobalPkgs = true;

    users.max = {
      imports = [
        ./home
        inputs.self.outputs.homeManagerModules.default
      ];
    };
  };
}

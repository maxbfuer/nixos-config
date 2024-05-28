{
  inputs,
  lib,
  ...
}: let
  my-lib = import ../lib/my-lib.nix {inherit lib;};
  imports = my-lib.importsFromDir ./.;
in {
  imports = imports ++ ["${inputs.impermanence}/home-manager.nix"];
}

{lib, ...}: let
  # produce a list of .nix files except for default.nix under "dir"
  importsFromDir = dir:
    builtins.filter
    (path: builtins.match ".*importer.nix" "${path}" == null && lib.hasSuffix ".nix" path)
    (lib.filesystem.listFilesRecursive dir);
in {
  inherit importsFromDir;
}

{pkgs, ...}: let
  scriptDir = ./scripts;
  scriptFiles = builtins.attrNames (builtins.readDir scriptDir);
  scriptPackages = map (file: pkgs.writeScriptBin file (builtins.readFile "${scriptDir}/${file}")) scriptFiles;
in {
  home.packages = scriptPackages;
}

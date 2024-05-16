{pkgs, ...}: let
  scripts = pkgs.buildEnv {
    name = "scripts";
    paths = [
      (pkgs.writeShellScriptBin "open_repo" (builtins.readFile ./open_repo))
      (pkgs.writeShellScriptBin "tokei_git" (builtins.readFile ./tokei_git))
    ];
  };
in {
  home.packages = [scripts];
}

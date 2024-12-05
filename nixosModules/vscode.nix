{
  lib,
  config,
  pkgs,
  system,
  nix-vscode-extensions,
  ...
}: let
  vscode-marketplace = nix-vscode-extensions.extensions.${system}.vscode-marketplace;
in {
  options = {
    vscode.enable = lib.mkEnableOption "install vscode";
  };

  config = lib.mkIf config.vscode.enable {
    environment.systemPackages = [
      (pkgs.vscode-with-extensions.override {
        vscodeExtensions = with vscode-marketplace; [
          ms-dotnettools.csdevkit # proprietary microsoft C# extension
          visualstudiotoolsforunity.vstuc # unity integration
        ];
      })
    ];
  };
}

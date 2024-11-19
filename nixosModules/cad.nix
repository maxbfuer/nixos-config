{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    cad.enable = lib.mkEnableOption "install CAD packages like FreeCAD and Prusa Slicer";
  };

  config = lib.mkIf config.cad.enable {
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          "cad"
          ".config/PrusaSlicer"
          ".config/FreeCAD"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      freecad
      prusa-slicer
    ];
  };
}

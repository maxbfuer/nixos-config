{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    cad.enable = lib.mkEnableOption "install cad packages like freecad and prusa slicer";
  };

  config = lib.mkIf config.cad.enable {
    home.persistence."/nix/persist/home/max" = {
      directories = [
        "cad"
        ".config/PrusaSlicer"
        ".config/FreeCAD"
      ];
    };

    home.packages = with pkgs; [
      freecad # parametric CAD software
      prusa-slicer # 3d printing slice
    ];
  };
}

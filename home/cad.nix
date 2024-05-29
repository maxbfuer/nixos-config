{pkgs, ...}: {
  home.persistence."/nix/persist/home/max" = {
    directories = [
      "cad"
      ".config/PrusaSlicer"
      ".config/FreeCAD"
    ];
  };

  home.packages = with pkgs; [
    freecad # parametric CAD software
    prusa-slicer # 3d printing slicer
  ];
}

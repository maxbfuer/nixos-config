{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.persistence."/nix/persist/home/max" = {
    directories = [
      "cad"
      ".config/PrusaSlicer"
      ".config/FreeCAD"
    ];
  };

  home.packages =
    (with pkgs; [
      freecad # parametric CAD software
    ])
    ++ (with pkgs-unstable; [
      prusa-slicer # 3d printing slicer
    ]);
}

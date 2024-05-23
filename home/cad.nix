{pkgs, ...}: {
  home.packages = with pkgs; [
    freecad # parametric CAD software
    prusa-slicer # 3d printing slicer
  ];
}

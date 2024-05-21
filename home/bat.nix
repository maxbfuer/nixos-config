{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
  ];

  home.sessionVariables = {
    MANROFFOPT = "-c";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };
}

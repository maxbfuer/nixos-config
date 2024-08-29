{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    bat.enable = lib.mkEnableOption "installs bat and uses it as MANPAGER";
  };

  config = lib.mkIf config.bat.enable {
    home.packages = with pkgs; [
      bat
    ];

    home.sessionVariables = {
      MANROFFOPT = "-c";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };
  };
}

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
    environment.systemPackages = [pkgs.bat];

    environment.sessionVariables = {
      MANROFFOPT = "-c";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };
  };
}

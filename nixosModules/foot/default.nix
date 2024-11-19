{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    foot.enable = lib.mkEnableOption "install and configure foot";
  };

  config = lib.mkIf config.foot.enable {
    environment.systemPackages = [pkgs.foot];

    system.userActivationScripts.createFootConf = ''
      install -Dm 444 ${./foot.ini} ~/.config/foot/foot.ini
    '';

    environment.sessionVariables = {
      TERMINAL = "foot";
    };
  };
}

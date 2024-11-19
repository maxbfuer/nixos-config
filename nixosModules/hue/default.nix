{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    hue.enable = lib.mkEnableOption "install and configure software for controlling philips hue system";
  };

  config = lib.mkIf config.hue.enable {
    environment.systemPackages = [pkgs.hueadm];

    system.userActivationScripts.createHueadmConf = ''
      install -Dm 444 ${./hueadm.json} ~/.hueadm.json
    '';
  };
}

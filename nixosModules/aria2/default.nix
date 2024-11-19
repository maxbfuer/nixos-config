{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    aria2.enable = lib.mkEnableOption "installs and configures aria2c";
  };

  config = lib.mkIf config.aria2.enable {
    environment.systemPackages = with pkgs; [
      aria2
    ];

    system.userActivationScripts.createAria2Conf = ''
      install -Dm 444 ${./aria2.conf} ~/.config/aria2/aria2.conf
    '';
  };
}

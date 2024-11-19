{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    tealdeer.enable = lib.mkEnableOption "install and configure tealdeer";
  };

  config = lib.mkIf config.tealdeer.enable {
    environment.systemPackages = with pkgs; [
      tealdeer
    ];

    system.userActivationScripts.createTealdeerConf = ''
      install -Dm 444 ${./config.toml} ~/.config/tealdeer/config.toml
    '';
  };
}

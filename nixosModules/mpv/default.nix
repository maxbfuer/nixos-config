{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    mpv.enable = lib.mkEnableOption "install and configure mpv";
  };

  config = lib.mkIf config.mpv.enable {
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          ".cache/mpv"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      mpv
    ];

    system.userActivationScripts.createMpvConf = ''
      install -Dm 444 ${./mpv.conf} ~/.config/mpv/mpv.conf
    '';
  };
}

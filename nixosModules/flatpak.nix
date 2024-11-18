{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    flatpak.enable = lib.mkEnableOption "add flatpak";
  };

  config = lib.mkIf config.flatpak.enable {
    environment.persistence."/nix/persist" = {
      directories = [
        "/var/lib/flatpak"
        {
          directory = "/home/max/.cache/flatpak";
          user = "max";
          group = "users";
          mode = "755";
        }
        {
          directory = "/home/max/.local/share/flatpak";
          user = "max";
          group = "users";
          mode = "755";
        }
      ];
    };

    services.flatpak.enable = true;

    # automatically add flatpak repo
    systemd.services.flatpak-repo = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}

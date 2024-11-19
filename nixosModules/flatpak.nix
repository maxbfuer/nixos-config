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
      ];
      users.max = {
        directories = [
          ".cache/flatpak"
          ".local/share/flatpak"
        ];
      };
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

{
  lib,
  config,
  ...
}: {
  options = {
    borg.enable = lib.mkEnableOption "enables borg backups";
  };

  config = lib.mkIf config.borg.enable {
    environment.persistence."/nix/persist" = {
      directories = [
        "/root/.config/borg"
      ];
      users.max = {
        directories = [
          ".config/borg"
        ];
      };
    };

    # hourly, mid-compressed backups of the persist partition
    services.borgbackup.jobs.persist = {
      paths = ["/nix/persist"];
      exclude = ["/nix/persist/var/lib/libvirt/images"];
      repo = "/mnt/storage/borg/persist";
      encryption.mode = "none";
      compression = "auto,zstd,9";
      startAt = "hourly";
      persistentTimer = true;
      doInit = false;

      prune.keep = {
        within = "2d";
        daily = 7;
        weekly = 4;
        monthly = 6;
        yearly = 2;
      };
    };

    # daily, heavy-compressed backups of the mediaserver config
    services.borgbackup.jobs.mediaserver-config = {
      paths = ["/home/max/repos/mediaserver"];
      repo = "/mnt/storage/borg/mediaserver-config";
      encryption.mode = "none";
      compression = "auto,zstd,19";
      startAt = "daily";
      persistentTimer = true;
      doInit = false;

      prune.keep = {
        within = "2d";
        daily = 7;
        weekly = 4;
        monthly = 6;
        yearly = 2;
      };
    };
  };
}

{...}: {
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
    };
  };
}

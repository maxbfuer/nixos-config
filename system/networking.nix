{pkgs, ...}: {
  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/iwd"
    ];
  };

  networking = {
    hostName = "gaia";
    wireless.iwd.enable = true;
  };
}

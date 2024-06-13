{pkgs, ...}: {
  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/iwd"
      "/etc/wireguard"
    ];
  };

  networking = {
    hostName = "gaia";
    wireless.iwd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];
}

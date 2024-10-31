{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    networking.enable = lib.mkEnableOption "enables networking";
  };

  config = lib.mkIf config.networking.enable {
    environment.persistence."/nix/persist" = {
      directories = [
        "/var/lib/iwd"
        "/etc/wireguard"
      ];
    };

    networking = {
      hostName = "gaia";
      wireless.iwd.enable = true;
      nameservers = ["1.1.1.1" "1.0.0.1"];
    };

    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];
  };
}

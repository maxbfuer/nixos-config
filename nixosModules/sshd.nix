{
  lib,
  config,
  ...
}: {
  options = {
    sshd.enable = lib.mkEnableOption "enables sshd";
  };

  config = lib.mkIf config.sshd.enable {
    environment.persistence."/nix/persist" = {
      files = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };

    services.openssh = {
      enable = true;
    };
  };
}

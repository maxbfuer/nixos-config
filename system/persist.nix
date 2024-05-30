{...}: {
  # TODO: virt-manager/libvirt settings to autostart network, somehow persist `virsh net-autostart default` or auto run `virsh net-start default`
  # TODO: make virsh -c 'qemu:///system' list work; maybe it's working I just haven't tried it while VM is running
  # TODO: virt-manager defaulting to qemu connection/socket to find my VMs
  # win11.qcow has been coped to /var/lib/libvirt/images and win11.xml has been updated but not tested
  environment.persistence."/nix/persist" = {
    files = [
      "/etc/machine-id"
    ];
    directories = [
      "/var/lib/iwd"
      "/var/lib/libvirt"
      "/var/lib/qemu"
      "/var/lib/systemd"
      "/var/lib/bluetooth"
      "/var/lib/docker"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/log"
      "/etc/nixos" # probably temporary
      # caches
      "/var/cache"
      "/root/.cache"
    ];
    users.max = {
      directories = [
        # TODO: these were having issues when configured using the HM impermanence module
        ".config/VSCodium"
        ".cache"
      ];
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    vfio.enable = lib.mkEnableOption "enables vfio";
  };

  config = lib.mkIf config.vfio.enable {
    boot = {
      # adding these modules to the initrd ensures the GPU is captured before the kernel tries to load drivers for it
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
      ];

      # capture the GPU's graphic and vfio PCI devices (my ZOTAC NVIDIA 3060 Ti in this case)
      kernelParams = ["vfio-pci.ids=10de:2489,10de:228b"];
    };

    environment.systemPackages = with pkgs; [
      virt-manager # libvirt GUI
      looking-glass-client
    ];
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm; # only install qemu for host architectures (x86_64 and i386), saves disk space
        swtpm.enable = true; # windows wants a TPM
      };
    };
    # allow the user access to the shared memory file used by looking-glass
    systemd.tmpfiles.rules = ["f /dev/shm/looking-glass 0660 max kvm -"];
    users.users.max.extraGroups = ["libvirtd"];
  };
}

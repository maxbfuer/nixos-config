{
  pkgs,
  config,
  ...
}: {
  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "vfio_virqfd"

      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernelParams = [
      "amd_iommu=on"
      "vfio-pci.ids=10de:2489,10de:228b"
    ];
  };
}

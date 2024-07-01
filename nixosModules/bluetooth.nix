{
  lib,
  config,
  ...
}: {
  options = {
    bluetooth.enable = lib.mkEnableOption "enables bluetooth and blueman manager";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true; # bluetooth manager GUI
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    android.enable = lib.mkEnableOption "Add features for manipulating android devices";
  };

  config = lib.mkIf config.android.enable {
    services.udev.packages = with pkgs; [
      android-udev-rules
    ];

    environment.systemPackages = with pkgs; [
      android-tools
    ];
  };
}

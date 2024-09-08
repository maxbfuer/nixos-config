{
  lib,
  config,
  ...
}: {
  options = {
    kde.enable = lib.mkEnableOption "enables KDE desktop environment";
  };

  config = lib.mkIf config.kde.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    services.desktopManager.plasma6.enable = true;
  };
}

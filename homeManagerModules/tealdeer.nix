{
  lib,
  config,
  ...
}: {
  options = {
    tealdeer.enable = lib.mkEnableOption "install and configure tealdeer";
  };

  config = lib.mkIf config.tealdeer.enable {
    programs.tealdeer = {
      enable = true;
      settings.updates = {
        auto_update = true;
        auto_update_interval_hours = 168; # weekly
      };
    };
  };
}

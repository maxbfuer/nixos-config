{
  lib,
  config,
  ...
}: {
  options = {
    doas.enable = lib.mkEnableOption "enables doas";
  };

  config = lib.mkIf config.doas.enable {
    security.doas = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}

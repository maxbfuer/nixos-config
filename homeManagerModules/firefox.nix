{
  lib,
  config,
  ...
}: {
  options = {
    firefox.enable = lib.mkEnableOption "installs and configures firefox";
  };

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
    };
  };
}

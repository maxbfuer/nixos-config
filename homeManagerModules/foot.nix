{
  lib,
  config,
  ...
}: {
  options = {
    foot.enable = lib.mkEnableOption "install and configure foot";
  };

  config = lib.mkIf config.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "MesloLGS NF:size=12";
        };
      };
    };

    home.sessionVariables = {
      TERMINAL = "foot";
    };
  };
}

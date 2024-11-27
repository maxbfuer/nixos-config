{
  lib,
  config,
  ...
}: {
  options = {
    ydotool.enable = lib.mkEnableOption "install and enable ydotool service";
  };

  config = lib.mkIf config.ydotool.enable {
    programs.ydotool.enable = true;

    users.users.max.extraGroups = ["ydotool"];
  };
}

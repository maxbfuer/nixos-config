{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    unity.enable = lib.mkEnableOption "install unity game development tools";
  };

  config = lib.mkIf config.unity.enable {
    environment.persistence."/nix/persist" = {
      directories = [
        {
          directory = "/home/max/Unity";
          user = "max";
          group = "users";
          mode = "755";
        }
        {
          directory = "/home/max/UnityProjects";
          user = "max";
          group = "users";
          mode = "755";
        }
        {
          directory = "/home/max/.config/unityhub";
          user = "max";
          group = "users";
          mode = "755";
        }
        {
          directory = "/home/max/.config/unity3d";
          user = "max";
          group = "users";
          mode = "755";
        }
      ];
    };

    environment.systemPackages = with pkgs; [
      unityhub
    ];
  };
}

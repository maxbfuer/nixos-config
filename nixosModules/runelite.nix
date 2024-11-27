{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    runelite.enable = lib.mkEnableOption "installs runelite";
  };

  config = lib.mkIf config.runelite.enable {
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          ".runelite"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      runelite
    ];
  };
}

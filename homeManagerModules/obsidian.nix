{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    obsidian.enable = lib.mkEnableOption "install obsidian";
  };

  config = lib.mkIf config.obsidian.enable {
    home.persistence."/nix/persist/home/max" = {
      directories = [
        "obby"
        ".config/obsidian"
      ];
    };

    home.packages = with pkgs; [
      obsidian
    ];
  };
}

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
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          "obby"
          ".config/obsidian"
        ];
      };
    };

    environment.systemPackages = [pkgs.obsidian];
  };
}

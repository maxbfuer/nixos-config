{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    freetube.enable = lib.mkEnableOption "install freetube";
  };

  config = lib.mkIf config.freetube.enable {
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          ".config/FreeTube"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      freetube
    ];
  };
}

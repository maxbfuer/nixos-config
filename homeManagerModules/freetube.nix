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
    home.persistence."/nix/persist/home/max" = {
      directories = [
        ".config/FreeTube"
      ];
    };

    # TODO: declare settings via programs.freetube.settings
    home.packages = with pkgs; [
      freetube
    ];
  };
}

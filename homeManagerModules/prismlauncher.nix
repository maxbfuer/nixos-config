{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    prismlauncher.enable = lib.mkEnableOption "install prism launcher";
  };

  config = lib.mkIf config.prismlauncher.enable {
    home.persistence."/nix/persist/home/max" = {
      directories = [
        ".local/share/PrismLauncher"
      ];
    };

    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}

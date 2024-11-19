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
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          ".local/share/PrismLauncher"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
  };
}

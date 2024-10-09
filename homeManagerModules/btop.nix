{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    btop.enable = lib.mkEnableOption "install btop";
  };

  config = lib.mkIf config.btop.enable {
    home.persistence."/nix/persist/home/max" = {
      directories = [
        ".config/btop"
      ];
    };

    home.packages = with pkgs; [
      btop
    ];
  };
}

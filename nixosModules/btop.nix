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
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          ".config/btop"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      btop
    ];
  };
}

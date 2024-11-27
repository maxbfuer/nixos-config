{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    thunderbird.enable = lib.mkEnableOption "install thunderbird";
  };

  config = lib.mkIf config.thunderbird.enable {
    environment.persistence."/nix/persist" = {
      users.max = {
        directories = [
          ".thunderbird"
          ".mozilla"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      thunderbird
    ];
  };
}

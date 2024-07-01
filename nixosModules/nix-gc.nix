{
  lib,
  config,
  ...
}: {
  options = {
    nix-gc.enable = lib.mkEnableOption "enables nix gc";
  };

  config = lib.mkIf config.nix-gc.enable {
    # weekly garbage collection
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    nix.settings.auto-optimise-store = true;
  };
}

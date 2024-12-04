{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    printing.enable = lib.mkEnableOption "enables printing (CUPS)";
  };

  config = lib.mkIf config.printing.enable {
    services.printing = {
      enable = true;
      # I was able to get things working using the CUPS localhost interface
      # TODO remove driver, pretty sure it does not work and isn't needed
      # TODO persist printer stuff
      drivers = [pkgs.brlaser];
    };

    # enable printer discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}

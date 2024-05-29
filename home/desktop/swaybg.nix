{pkgs, ...}: {
  home.persistence."/nix/persist/home/max" = {
    directories = [
      ".local/share/wallpapers"
    ];
  };

  home.packages = with pkgs; [
    swaybg
    gallery-dl
  ];
}

{pkgs, ...}: {
  home.persistence."/nix/persist/home/max" = {
    directories = [
      ".config/btop"
    ];
  };

  home.packages = with pkgs; [
    btop
  ];
}

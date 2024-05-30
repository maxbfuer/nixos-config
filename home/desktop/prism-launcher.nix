{pkgs, ...}: {
  home.persistence."/nix/persist/home/max" = {
    directories = [
      ".local/share/PrismLauncher"
    ];
  };

  home.packages = with pkgs; [
    prismlauncher
  ];
}

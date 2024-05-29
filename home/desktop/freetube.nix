{pkgs, ...}: {
  home.persistence."/nix/persist/home/max" = {
    directories = [
      ".config/FreeTube"
    ];
  };

  # TODO: declare settings via programs.freetube.settings
  home.packages = with pkgs; [
    freetube
  ];
}

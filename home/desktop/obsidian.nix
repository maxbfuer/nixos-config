{pkgs, ...}: {
  home.persistence."/nix/persist/home/max" = {
    directories = [
      "obby"
      ".config/obsidian"
    ];
  };

  home.packages = with pkgs; [
    obsidian
  ];
}

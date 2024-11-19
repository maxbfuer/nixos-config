{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "max";
  home.homeDirectory = "/home/max";

  home.persistence."/nix/persist/home/max" = {
    directories = [
      "Downloads"
      "workspace"

      # caches
      # ".cache"
      ".cargo"

      # TODO: move these, and change mode/permissions somehow?
      # not sure if necessary: I was using "mode = 700" in environment.persistence, but HM doesn't seem to have that
      ".ssh"
      ".gnupg"
    ];
  };

  home.packages = with pkgs; [
    tokei # project code counter
    unzip

    wl-clipboard # clipboard
    gammastep # adjust color temperature
    blueman # bluetooth device manager GUI
    pavucontrol # audio control GUI
  ];

  # home manager will install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";

  vscodium.enable = true;
  prismlauncher.enable = true;
  obsidian.enable = true;
  ungoogled-chromium.enable = true;
  tealdeer.enable = true;
}

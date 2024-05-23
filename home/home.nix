{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "max";
  home.homeDirectory = "/home/max";

  home.packages = with pkgs; [
    tokei # project code counter

    wl-clipboard # clipboard
    gammastep # adjust color temperature
    blueman # bluetooth device manager GUI
    pavucontrol # audio control GUI
    obsidian # markdown knowledge base
  ];

  # home manager will install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}

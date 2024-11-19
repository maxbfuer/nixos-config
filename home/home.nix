{...}: {
  home.username = "max";
  home.homeDirectory = "/home/max";

  # home manager will install and manage itself
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";

  vscodium.enable = true;
  ungoogled-chromium.enable = true;
  tealdeer.enable = true;
}

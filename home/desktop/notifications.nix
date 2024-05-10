{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify # provides `notify-send`
  ];

  # lightweight wlroots notification daemon
  services.fnott = {
    enable = true;
  };
}

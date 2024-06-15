{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify # provides `notify-send`
  ];

  # lightweight wlroots notification daemon
  services.fnott = {
    enable = true;
    settings = {
      main = {
        output = "DP-1";
        selection-helper = "tofi";
        min-width = 160;
        padding-vertical = 10;
        padding-horizontal = 10;
        default-timeout = 10;
        max-timeout = 20;
        # notifications will not time out if I am idle
        idle-timeout = 5;
        # border-color?
      };
    };
  };
}

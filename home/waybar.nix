{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        positon = "top";
        height = 30;
        modules-left = ["dwl/tags"];
        modules-center = ["dwl/window"];
        modules-right = ["cpu" "tray" "clock"];
      };
    };
  };
}

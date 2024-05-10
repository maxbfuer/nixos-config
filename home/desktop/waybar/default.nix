{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        positon = "top";
        modules-left = ["dwl/tags"];
        modules-center = ["dwl/window"];
        modules-right = ["cpu" "tray" "clock"];

        "cpu" = {
          format = " {usage}% {max_frequency} GHz";
        };
      };
    };

    style = ./style.css;
  };
}

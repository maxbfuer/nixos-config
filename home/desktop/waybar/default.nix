{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        positon = "top";
        modules-left = ["dwl/tags" "dwl/window"];
        modules-center = ["clock"];
        modules-right = ["network" "memory" "cpu" "temperature" "disk" "tray"];

        "network" = {
          interface = "wlan0";
          format = "󰶼{bandwidthUpBytes} 󰶹{bandwidthDownBytes}";
          interval = 2;
          max-length = 20;
        };

        "memory" = {
          format = "󰍛 {used:0.1f}GiB/{total:0.1f}GiB";
          interval = 2;
        };

        "cpu" = {
          format = " {usage}%";
          interval = 2;
        };

        "temperature" = {
          format = "{temperatureC}°C";
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input"; # Tctl
          interval = 2;
        };

        "disk" = {
          format = " {percentage_used}%";
          unit = "GB";
          interval = 60;
        };
      };
    };

    style = ./style.css;
  };
}

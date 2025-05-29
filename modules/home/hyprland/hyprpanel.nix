{ inputs, vars, ... }:

{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    overlay.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;

    settings = {
      layout = {
        "bar.layouts" = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [
              "media"
              "clock"
            ];
            right = [
              "volume"
              "bluetooth"
              "network"
              "systray"
              "battery"
              "notifications"
            ];
          };
        };
      };

      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
        weather.location = vars.city;
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;

      theme.font = {
        name = "JetBrains Mono NL";
        size = "15px";
      };
    };
  };
}

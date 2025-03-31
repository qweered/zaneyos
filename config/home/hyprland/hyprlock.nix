{
  # CONFIG: I miss you for X hours (since last login), steal https://github.com/Tamarindtype/googlish-hyprlock-theme
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = true;
        grace = 1;
        disable_loading_bar = false;
        hide_cursor = false;
        ignore_empty_input = true;
        text_trim = true;
      };

      background = [
        {
          # monitor = ""; works
          # CONFIG: wallpaper
          path = "screenshot";
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.7172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0;
        }
      ];

      input-field = [
        {
          monitor = "eDP-1";
          size = "300, 50";
          outline_thickness = 1;

          outer_color = "rgb(b6c4ff)";
          inner_color = "rgb(dce1ff)";
          font_color = "rgb(354479)";

          fade_on_empty = false;
          placeholder_text = ''<span foreground="##354479">Password</span>'';

          dots_spacing = 0.2;
          dots_center = true;
        }
      ];

      label = [
        {
          text = "$TIME";
          font_size = 50;
          color = "rgb(b6c4ff)";

          position = "0, 150";

          valign = "center";
          halign = "center";
        }
        {
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 20;
          color = "rgb(b6c4ff)";

          position = "0, 50";

          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}

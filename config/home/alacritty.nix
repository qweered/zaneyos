{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding.x = 15;
        padding.y = 15;
        decorations = "none";
        startup_mode = "Windowed";
        dynamic_title = true;
        opacity = 0.6;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
      };
      general = {
        live_config_reload = true;
      };
      font = {
        normal.family = "JetBrainsMono NFM";
        bold.family = "JetBrainsMono NFM";
        italic.family = "JetBrainsMono NFM";
        bold_italic.family = "JetBrainsMono NFM";
        size = 14;
      };
      colors.draw_bold_text_with_bright_colors = true;
    };
  };
}

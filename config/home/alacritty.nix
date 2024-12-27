{
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = "fish"; # TODO: remove?
      window = {
        padding.x = 15;
        padding.y = 15;
        decorations = "none";
        opacity = 0.6;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
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

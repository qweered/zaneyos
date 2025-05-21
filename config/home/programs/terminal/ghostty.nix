{pkgs, ...}:
{
  # TODO: replace with something better if they will not fix slowness
  # over alacritty (slow development), ghostty (1 sec startup)

  home.packages = with pkgs; [
        kitty
        foot
        wezterm
  ];


  #programs.ghostty = {
  #  enable = true;
  #  settings = {
  #    window-decoration = false;
  #  };
  #};

}

{
  # CONFIG, is better than tmux?
  programs.zoxide = {
    enable = true;
  };
  services.playerctld.enable = true;
  services.mpd.enable = true;
  services.hyprpolkitagent.enable = true; # + 90mb if no other kde packages, am i need it?
  # lazydocker

  # yt-dlp

  # Testing

  # programs.imv.enable = true; - image viewer, loupe?
  # programs.zathura.enable = true; - pdf viewer
  # wget
  #    wluma
  #    bat # over cat
  #    unzip zip rar unrar ?
  # mc superfile xplr ranger lf nnn yazi broot
  # walker anyrun

  # Testing finished

  # activate-linux # windows watermark
}

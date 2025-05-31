{ pkgs, ... }:
{
  # CONFIG, is better than tmux?
  programs.zoxide = {
    enable = true;
  };
  # CONFIG
  services.playerctld.enable = true;
  # CONFIG
  services.mpd.enable = true;

  home.packages = with pkgs; [
    wl-clipboard # over wl-clipboard-rs (conflicts with hyprpanel probably)
    libnotify # send notifications programmatically

    grim
    slurp
    satty # over hyprshot swappy

    # cleaned up to here
    playerctl
    hyperfine
    lazyjournal
    hyprpicker
    pulseaudio


    # try lazydocker

    # yt-dlp
    # hyprpolkitagent

    # Testing

    # programs.imv.enable = true; - image viewer, loupe?
    # programs.zathura.enable = true; - pdf viewer
    # wget
    #    wluma
    #    ripgrep
    #    bat # over cat
    #    unzip zip rar unrar ?
    # mc superfile xplr ranger lf nnn yazi broot
    # walker anyrun

    # Testing finished

    # activate-linux # windows watermark
  ];
}

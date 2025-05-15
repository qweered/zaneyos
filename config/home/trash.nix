{
  pkgs,
  ...
}:

{
  # TODO: is this convention or something or even needed
  home.sessionVariables.BROWSER = "vivaldi";

  # CONFIG, is better than tmux?
  programs.zoxide = {
    enable = true;
  };
  # CONFIG
  services.playerctld.enable = true;
  # CONFIG
  services.mpd.enable = true;

  home.packages = with pkgs; [
    wl-clipboard # over wl-clipboard-rs (broken)
    libnotify # send notifications programmatically

    grim
    slurp
    satty # over hyprshot swappy

    brightnessctl
    playerctl
    hyperfine
    lazygit
    lazyjournal
    hyprpicker
    pulseaudio

    # Checked up to here

    # try lazydocker

    # hyprpolkitagent
    # swww? waypaper & hyprpaper in hm

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

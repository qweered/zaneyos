{ pkgs, ... }:
{
  # CONFIG: look and configure them all if needed
  home.packages = with pkgs; [
    btop # over htop, mission-center
    gdu # du alternative, over dua dust dutree pdu godu ncdu duc diskus
    eza # ls alternative, over exa, lsd
    duf # df alternative, over dysk (2 best) pydf di dfc dfrs
    procs # process viewer, over ps aux
    ripgrep # grep/ack alternative
    fzf # fuzzy finder
    wl-clipboard # clipboard in shell, over wl-clipboard-rs (conflicts with hyprpanel probably)
    libnotify # notifications in shell
    ffmpeg # video/audio converter
    grim
    slurp
    satty # screenshot tools, over hyprshot swappy
    hyperfine # speed benchmarks
    lazyjournal # over dmesg, journalctl
    hyprpicker # color picker
    wget # download files, over curl
    bat # cat alternative
    yt-dlp # download videos
    lazydocker # docker in terminal

    jq
    # zathura imv # pdf/image viewer
    # wluma # automatic brightness control
    # unzip zip rar unrar # over 7z
    # mc superfile xplr ranger lf nnn yazi broot # over ranger
    # walker anyrun # over rofi
    # activate-linux # fun windows watermark
  ];
}

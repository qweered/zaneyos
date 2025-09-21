{ pkgs, ... }:

{
  # CONFIG: look and configure them all if needed
  home.packages = with pkgs; [
    btop # process viewer, over htop, mission-center
    gdu # du alternative, over dua dust dutree pdu godu ncdu duc diskus
    eza # ls alternative, over exa, lsd
    bat # cat alternative
    lazyjournal # over dmesg, journalctl
    duf # df alternative, over dysk (2 best) pydf di dfc dfrs
    rip2 # rm, trash-cli alternative
    procs # process viewer, over ps aux
    ripgrep # grep/ack alternative
    fzf # fuzzy finder
    hyperfine # speed benchmarks
    ffmpeg # video/audio converter

    wl-clipboard # clipboard in shell, over wl-clipboard-rs (conflicts with hyprpanel probably)
    libnotify # notifications in shell
    grim
    slurp
    satty # screenshot tools, over hyprshot swappy
    hyprpicker # color picker
    wget # download files, over curl
    yt-dlp # download videos
    xxh # transfer shell config over ssh
    sshpass # needed for xxh

    fd # fuzzy finder in lazyvim currently TODO remove
    jq
    # zathura imv # pdf/image viewer
    # wluma # automatic brightness control
    # unzip zip rar unrar # over 7z
    # mc superfile xplr ranger lf nnn yazi broot # over ranger
    # walker anyrun # over rofi
    # activate-linux # fun windows watermark
  ];
}

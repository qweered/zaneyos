{ pkgs, ... }:
{
  # CONFIG: look and configure them all if needed
  home.packages = [
    pkgs.btop # over htop, mission-center
    pkgs.gdu # du alternative, over dua dust dutree pdu godu ncdu duc diskus
    pkgs.eza # ls alternative, over exa, lsd
    pkgs.duf # df alternative, over dysk (2 best) pydf di dfc dfrs
    pkgs.procs # process viewer, over ps aux
    pkgs.ripgrep # grep/ack alternative
    pkgs.wl-clipboard # clipboard in shell, over wl-clipboard-rs (conflicts with hyprpanel probably)
    pkgs.libnotify # notifications in shell
    pkgs.ffmpeg # video/audio converter
    pkgs.grim
    pkgs.slurp
    pkgs.satty # screenshot tools, over hyprshot swappy
    pkgs.hyperfine # speed benchmarks
    pkgs.lazyjournal # over dmesg, journalctl
    pkgs.hyprpicker # color picker
    pkgs.wget # download files, over curl
    pkgs.bat # cat alternative
    pkgs.yt-dlp # download videos
    pkgs.lazydocker # docker in terminal

    pkgs.jq
    # Additional packages to consider:
    # pkgs.zathura pkgs.imv # pdf/image viewer
    # pkgs.wluma # automatic brightness control
    # pkgs.unzip pkgs.zip pkgs.rar pkgs.unrar # over 7z
    # pkgs.mc pkgs.superfile pkgs.xplr pkgs.ranger pkgs.lf pkgs.nnn pkgs.yazi pkgs.broot # over ranger
    # pkgs.walker pkgs.anyrun # over rofi
    # pkgs.activate-linux # fun windows watermark
  ];
}

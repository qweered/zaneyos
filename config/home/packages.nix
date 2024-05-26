{ pkgs, username, host, ... }:

let
  inherit (import ../../hosts/${host}/options.nix)
  browser wallpaperDir wallpaperGit flakeDir;
in {
#  sessionVariables.BROWSER = "vivaldi";
  home.packages = with pkgs; [
    # For nur use config.nur.something
    gnome.file-roller imv
    swayidle swaylock
    jetbrains-toolbox
    pavucontrol
    mpv
    zoom-us
    telegram-desktop # replace with ayugram
    # ranger lf nnn
    vesktop
    google-chrome pkgs."${browser}"
    qbittorrent
    nodejs bun

    morewaita-icon-theme
    gnome.adwaita-icon-theme
    qogir-icon-theme
    loupe
    gnome.gnome-boxes
    gnome.gnome-weather
    gnome.gnome-clocks
    wl-gammactl
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir; inherit username; inherit wallpaperGit; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; inherit host; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/screenshootin.nix { inherit pkgs; })
  ];
}

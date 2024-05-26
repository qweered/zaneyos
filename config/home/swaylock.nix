{ pkgs, config, ... }:

let
#  palette = config.colorScheme.palette;
in {
  home.file.".config/swaylock/config".text = ''
    indicator-caps-lock
    show-failed-attempts
    ignore-empty-password
    indicator-thickness=15
    indicator-radius=150
    image=~/.config/swaylock-bg.jpg
    line-color=00000000
    inside-color=00000088
    inside-clear-color=00000088
    separator-color=00000000
    font=Ubuntu
  '';
}

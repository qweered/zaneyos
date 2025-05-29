{ pkgs, ... }:
{
  # CONFIG: look and configure them all
  home.packages = with pkgs; [
    gdu # du alternative, over dua dust dutree pdu godu ncdu duc diskus
    eza # ls alternative, over exa, lsd
    duf # df alternative, over dysk (2 best) pydf di dfc dfrs
    procs # over ps aux
    ripgrep # over grep, ack
  ];
}

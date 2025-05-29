{ pkgs, ... }:
{
  # over deluge, transmission
  # TODO: what is qbittorrent-enhanced?
  home.packages = with pkgs; [ qbittorrent ];
}

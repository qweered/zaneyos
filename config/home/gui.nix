{ pkgs, inputs, ... }:

let
  ayugram-desktop = inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop;
in
{
  # TODO: add to cfg
  home.sessionVariables.BROWSER = "vivaldi";

  home.packages = with pkgs; [
    vivaldi
    google-chrome

    qbittorrent # over deluge, transmission
    pwvucontrol # over pavucontrol, pulsemixer
    rustdesk-flutter

    obsidian
    wpsoffice # over libreoffice, onlyoffice-desktopeditors

    equibop
    ayugram-desktop
    teams-for-linux
    zoom-us
  ];
}

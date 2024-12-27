{ pkgs, inputs, cfg, ... }:

let
  ayugram-desktop = inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop;
in
{
  home.sessionVariables.BROWSER = cfg.browser;

  home.packages = with pkgs; [
    (pkgs.${cfg.browser})
    google-chrome

    qbittorrent # over deluge, transmission
    pwvucontrol # over pavucontrol, pulsemixer
    rustdesk-flutter

    obsidian
    wpsoffice # over libreoffice, onlyoffice-desktopeditors

    equibop
    ayugram-desktop # TODO: replace with something other, adds 2GB to closure
    teams-for-linux
    zoom-us
  ];
}

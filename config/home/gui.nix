{ pkgs, inputs, cfg, ... }:

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
#    ayugram-desktop # TODO: replace with something other, adds 2GB to closure
    materialgram
    teams-for-linux
    zoom-us
  ];
}

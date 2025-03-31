{ cfg, pkgs, ... }:

{
  imports = [
    ./spicetify.nix
  ];

  home.sessionVariables.BROWSER = cfg.browser;

  home.packages = with pkgs; [
    (pkgs.${cfg.browser})
    google-chrome

    qbittorrent # over deluge, transmission
    pwvucontrol # over pavucontrol, pulsemixer
   # TODO: broken in nixos-unstable
   # rustdesk-flutter

    obsidian
    # wpsoffice # over libreoffice, onlyoffice-desktopeditors
    libreoffice # adds 1.7 GB to storage

    equibop
    ayugram-desktop
    teams-for-linux
    zoom-us
  ];
}

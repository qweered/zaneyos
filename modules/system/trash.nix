{ pkgs, ... }:
{
  # CONFIG: I can generate custom menu items in thunar
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true; # mount, trash, and other functionalities
  services.tumbler.enable = true; # thumbnail support for images
  programs.file-roller.enable = true; # over ark, gui zip manager for thunar

  # Other services
  programs.dconf.enable = true; # for gnome related stuff
  programs.xfconf.enable = true; # store gnome preferences
  services.fstrim.enable = true; # periodically trim ssd
  services.upower.enable = true; # power daemon, used by eg. chromium
  services.power-profiles-daemon.enable = true; # power daemon, for laptops mainly
  services.devmon.enable = true; # device mounting daemon
  services.udisks2.enable = true; # disk storage daemon

  # Fish
  programs.fish.enable = true;
  documentation.man.generateCaches = true; # very slow for fish

  # Dynamic swap file
  services.swapspace.enable = true;
  zramSwap.enable = true;

  environment.systemPackages = with pkgs; [
    youtube-music
  ];

  # Checked up to here
  services.userborn.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gnome-keyring.enableGnomeKeyring = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ oxlint ];
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];
}

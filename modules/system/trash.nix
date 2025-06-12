{ pkgs, ... }:
{
  # CONFIG: I can generate custom menu items in thunar
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true; # Store preferences
    dconf.enable = true; # Needed for gnome related applications
    file-roller.enable = true; # over ark, gui zip manager for thunar
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Fish
  programs.fish.enable = true;
  documentation.man.generateCaches = false; # very slow for fish

  # Dynamic swap file
  services.swapspace.enable = true;
  zramSwap.enable = true;

  system.rebuild.enableNg = true; # will become default

  # Checked up to here
  # system.etc.overlay.enable = lib.mkDefault true; crashes my system
  hardware.brillo.enable = true; # over brightnessctl (smooth transitions)
  services.userborn.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gnome-keyring.enableGnomeKeyring = true;

  systemd.enableStrictShellChecks = true; # TODO: will become default

  services.automatic-timezoned.enable = true;
  time = {
    hardwareClockInLocalTime = true; # fixes dual-boot with Windows
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];

  services.dbus.implementation = "broker";

  environment.systemPackages = with pkgs; [
    uutils-findutils
    uutils-diffutils
    uutils-coreutils-noprefix
  ];

  services = {
    fstrim.enable = true; # periodically trim ssd
    fwupd.enable = true; # periodically update drivers
    upower.enable = true; # power daemon, used by eg. chromium
    power-profiles-daemon.enable = true; # power daemon, for laptops mainly
    devmon.enable = true; # device mounting daemon
    udisks2.enable = true; # disk storage daemon
    # accounts-daemon.enable = true; accounts daemon
  };
}

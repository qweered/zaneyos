{
  inputs,
  pkgs,
  lib,
  cfg,
  ...
}:

{

  # File management
  # I also can generate custom menu items in thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  programs.xfconf.enable = true; # Store preferences
  programs.dconf.enable = true; # Needed for gnome related applications
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  programs.file-roller.enable = true; # over ark, gui zip manager for thunar

  # Fish
  programs.fish.enable = true;
  documentation.man.generateCaches = false; # very slow for fish

  # Dynamic swap file
  services.swapspace.enable = true;
  zramSwap.enable = true;

  # Checked up to here
  system.etc.overlay.enable = lib.mkDefault false; # TODO: needed for perlless
  services.userborn.enable = lib.mkDefault true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gnome-keyring.enableGnomeKeyring = true;

  xdg = {
    terminal-exec.enable = true;
    terminal-exec.package = pkgs.ghostty;
  };

  systemd.enableStrictShellChecks = true; # TODO: will become default

  # TODO: Setup automatic timezone setting
  time = {
    timeZone = "Europe/Vilnius";
    hardwareClockInLocalTime = true; # fixes dual-boot with Windows
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];
  users = {
    mutableUsers = true;
  };

  system.stateVersion = cfg.version;
  services.dbus.implementation = "broker";

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

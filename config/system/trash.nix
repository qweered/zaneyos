{ inputs, pkgs, lib, cfg, ... }:

# TODO: refactor into services and programs

{
  imports = [
    inputs.ucodenix.nixosModules.default
  ];

  # File management
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  programs.xfconf.enable = true; # Store preferences
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # CONFIG: add aliases for unzip and zip
  programs.file-roller.enable = true; # over ark

  programs.dconf.enable = true;
  programs.fish.enable = true;
  documentation.man.generateCaches = false;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gnome-keyring.enableGnomeKeyring = true;

  # CONFIG: need to run
  # sudo virsh net-autostart default
  # on each new nixos machine, setup it in nixos way
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # NOTE: This is only for AMD processors. See https://github.com/e-tho/ucodenix
  services.ucodenix = {
    enable = true;
    cpuModelId = "00860F81"; # Run cpuid -1 -l 1 -r | sed -n 's/.*eax=0x\([0-9a-f]*\).*/\U\1/p' to retrieve processor's model ID
  };

  xdg = {
    terminal-exec.enable = true;
    terminal-exec.package = pkgs.ghostty;
  };

  # Remove non-required packages
  environment.defaultPackages = lib.mkDefault [ ];
  programs.nano.enable = false;

  documentation.nixos.enable = false; # ???????
  systemd.enableStrictShellChecks = true;

  # CONFIG: Setup automatic timezone setting
  time = {
    timeZone = "Europe/Vilnius";
    hardwareClockInLocalTime = true; # fixes dualboot with Windows
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
    #        devmon.enable = true; device mounting daemon
    #        udisks2.enable = true; disk storage daemon
    #        accounts-daemon.enable = true; accounts daemon
  };
}

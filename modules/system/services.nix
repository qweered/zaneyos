{
  # CONFIG: is this nicely formatted?
  hardware.brillo.enable = true; # over brightnessctl (smooth transitions)
  services.fwupd.enable = true; # periodically update drivers
  services.automatic-timezoned.enable = true; # time zone daemon
  programs.dconf.enable = true; # for gnome related stuff
  programs.xfconf.enable = true; # store gnome preferences
  services.fstrim.enable = true; # periodically trim ssd
  services.upower.enable = true; # power daemon, used by eg. chromium
  services.power-profiles-daemon.enable = true; # power daemon, for laptops mainly
  services.devmon.enable = true; # device mounting daemon
  services.udisks2.enable = true; # disk storage daemon
  services.gvfs.enable = true; # mount, trash, etc in file managers
  services.tumbler.enable = true; # thumbnails in file managers
  services.userborn.enable = true; # declarative users
  programs.fish.enable = true; # best shell
  services.gnome.gnome-keyring.enable = true; # store secrets
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true; # does not work https://github.com/NixOS/nixpkgs/issues/86884
}

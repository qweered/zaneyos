{
  programs.dconf.enable = true;
  programs.fuse.userAllowOther = true; # TODO: what is that

  services.fstrim.enable = true;
  services.fwupd.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gnome-keyring.enableGnomeKeyring = true;

  # TODO: setup gpg, vvirtualisation
  # TODO: replace sudo with doas

  #  services = {
  #    devmon.enable = true; device mounting daemon
  #    udisks2.enable = true; disk daemon
  #    upower.enable = true; power daemon
  #    power-profiles-daemon.enable = true; power daemon
  #    accounts-daemon.enable = true; accounts daemon
  #  };
}

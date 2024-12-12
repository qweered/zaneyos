{
  programs.dconf.enable = true;
  programs.fuse.userAllowOther = true; # TODO: what is that

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gnome-keyring.enableGnomeKeyring = true;

  # TODO: need to run
  # sudo virsh net-autostart default
  # on each new nixos machine
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # TODO: setup gpg, snap, flatpack, distrobox, docker?
  # TODO: replace sudo with doas

  # TODO: This is only for AMD processors. See https://github.com/e-tho/ucodenix
  services.ucodenix = {
    enable = true;
    cpuModelId = "00860F81"; # Run cpuid -1 -l 1 -r | sed -n 's/.*eax=0x\([0-9a-f]*\).*/\U\1/p' to retrieve processor's model ID
  };

  services = {
    fstrim.enable = true; # periodically trim ssd
    fwupd.enable = true; # periodically update drivers
    upower.enable = true; # power daemon, used by eg. chromium
    #    devmon.enable = true; device mounting daemon
    #    udisks2.enable = true; disk storage daemon
    #    power-profiles-daemon.enable = true; power daemon
    #    accounts-daemon.enable = true; accounts daemon
  };
}

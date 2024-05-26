{ pkgs, config, lib, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "32/48000";
            pulse.default.req = "32/48000";
            pulse.max.req = "32/48000";
            pulse.min.quantum = "32/48000";
            pulse.max.quantum = "32/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "32/48000";
        resample.quality = 1;
      };
    };
  };

  programs.thunar.enable = true;
  security.rtkit.enable = true;
  services = {
        openssh.enable = true;
        fstrim.enable = true;
        gvfs.enable = true;
        devmon.enable = true;
        udisks2.enable = true;
        upower.enable = true;
        power-profiles-daemon.enable = true;
        accounts-daemon.enable = true;
        tumbler.enable = true;
        gnome.gnome-keyring.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General.Experimental = true;
  services.blueman.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}

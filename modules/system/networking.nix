{ config, ... }:

{
  networking = {
    networkmanager.enable = true;
    # Configure connectivity check for captive portals
    # This is a standard configuration for NetworkManager connectivity checking
    networkmanager.settings.connectivity = {
      uri = "http://nmcheck.gnome.org/check_network_status.txt";
      interval = 300; # Check every 5 minutes
    };
    networkmanager.wifi.powersave = true;
  };

  programs.nm-applet.enable = true;

  systemd.network = {
    enable = true;
    wait-online.enable = !config.programs.nm-applet.enable;
  };
}

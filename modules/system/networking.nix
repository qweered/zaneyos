{ config, ... }:

{
  networking = {
    networkmanager.enable = true;
    networkmanager.settings.connectivity.uri = "http://nmcheck.gnome.org/check_network_status.txt"; # for captive portals, TODO: contribute to nixpkgs https://wiki.archlinux.org/title/NetworkManager#Checking_connectivity
    networkmanager.wifi.powersave = true;
  };

  programs.nm-applet.enable = true;

  systemd.network = {
    enable = true;
    wait-online.enable = !config.programs.nm-applet.enable;
  };
}

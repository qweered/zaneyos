{
  networking = {
    firewall.enable = false; # CONFIG
    networkmanager = {
      enable = true;
      wifi.powersave = true;
      # for captive portals but don't work it seems
      # TODO: contribute to nixpkgs https://wiki.archlinux.org/title/NetworkManager#Checking_connectivity
      settings.connectivity.uri = "http://nmcheck.gnome.org/check_network_status.txt";
    };
  };

  programs.nm-applet.enable = true;
}

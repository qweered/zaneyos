{ cfg, ... }:

{
  networking.hostName = "${cfg.hostname}";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;
  programs.nm-applet.enable = true; # needed for autoconnect or is this powersave issue?

  systemd.network.enable = true;
  systemd.network.wait-online.enable = false; # if networkmanager used

  # Doesn't work ideally
  # pcrograms.captive-browser.enable = true;
  # programs.captive-browser.interface = "wlo1";
}

{cfg, ...}:

{
  networking.hostName = "${cfg.hostname}";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;
  programs.nm-applet.enable = true; # needed for autoconnect or is this powersave issue?
}

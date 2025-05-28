{ cfg, config, ... }:

{
  networking = {
    hostName = "${cfg.hostname}";
    networkmanager.enable = true;
    networkmanager.wifi.powersave = true;
  };

  programs.nm-applet.enable = true;

  systemd.network = {
    enable = true;
    wait-online.enable = !config.programs.nm-applet.enable;
  };

  # TODO: Doesn't work ideally
  # programs.captive-browser.enable = true;
  # programs.captive-browser.interface = "wlo1";
}

{
  hardware.brillo.enable = true; # over brightnessctl (smooth transitions)
  services.fwupd.enable = true; # periodically update drivers
  services.automatic-timezoned.enable = true; # time zone daemon
}
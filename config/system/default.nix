{ cfg, ... }:

{
  imports = [
    ./../../hosts/${cfg.hostname}/hardware.nix
    ./../../users/users.nix
    # "${inputs.nix-mineral}/nix-mineral.nix"
    ./bluetooth.nix
    ./boot.nix
    ./displaymanager.nix
    ./fonts.nix
    ./keyboard.nix
    ./networking.nix
    ./nix.nix
    ./programs.nix
    ./services.nix
    ./sound.nix
  ];

  # Remove non-required packages
  environment.defaultPackages = [ ];

  # nix-mineral.enable = true; # TODO: broke system, wait for stable
  documentation.nixos.enable = false; # ???????
  systemd.enableStrictShellChecks = true;

  # TODO: Setup automatic timezone setting
  time = {
    timeZone = "Europe/Vilnius";
    hardwareClockInLocalTime = true; # fixes dualboot with Windows
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];
  users = {
    mutableUsers = true;
  };

  system.stateVersion = cfg.version;
}

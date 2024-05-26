{ hostname, host, ... }:

let
  inherit (import ./hosts/${host}/options.nix) 
  timeZone flakeDir userLocale version;
in {
  imports =
    [
      ./hosts/${host}/hardware.nix
      ./config/system
      ./users/users.nix
    ];

  networking.hostName = "${hostname}";
  networking.networkmanager.enable = true;

  time = {
    timeZone = "${timeZone}";
    hardwareClockInLocalTime = true; # For Windows dualboot to work properly FIXME: Windows
  };
  
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "${userLocale}"
  ];

  users = {
    mutableUsers = true;
  };

  environment.variables = {
    FLAKE = "${flakeDir}";
  };

  documentation.nixos.enable = false; # .desktop
  nix = {
    settings = {
      auto-optimise-store = true;
      warn-dirty = false;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 2d";
    };
  };

  system.stateVersion = version;
}

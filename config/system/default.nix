{ cfg, ... }:

{
  imports = [
    ./../hosts/${cfg.hostname}/hardware.nix
#    ./impermanence.nix
#    ./distrobox.nix
    ./users.nix
    ./bluetooth.nix
    ./boot.nix
    ./displaymanager.nix
    ./fonts.nix
    ./hyprland.nix
    ./keyboard.nix
    ./home-manager.nix
    ./networking.nix
    ./nix.nix
    ./sound.nix

    ./trash.nix
  ];

}

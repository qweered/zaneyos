{ ... }:

{
  imports = [
    ./ags.nix
    ./alacritty.nix
    ./bash.nix
    ./gtk-qt.nix
    ./hyprland.nix
#    ./kdeConnect.nix
#    ./nautilus.nix
    ./neovim.nix
    ./packages.nix
    ./swaylock.nix

    # Place Home Files Like Pictures
    ./files.nix
  ];
}

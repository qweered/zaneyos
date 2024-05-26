{ pkgs, config, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    noto-fonts-color-emoji material-icons brightnessctl swappy appimage-run playerctl
    nh
    libnotify # needed for custom notifications
    libsecret # needed for gnome-keyring?
    cmatrix # matrix in console
    virt-viewer
    neovide
    gnumake gcc clang python3
    tmux
    fastfetch tldr eza lsd unzip unrar zip wget curl btop
  ];

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };
    starship.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
    nm-applet.enable = true;
  };
  virtualisation.libvirtd.enable = true;

programs.spicetify =
     let
       spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
     in
     {
       enable = true;
       enabledExtensions = with spicePkgs.extensions; [
         adblock
         keyboardShortcut
         popupLyrics
         shuffle # shuffle+ (special characters are sanitized out of extension names)

         groupSession
         fullAlbumDate
         listPlaylistsWithSong
         playlistIntersection
         songStats
         lastfm
       ];
       theme = spicePkgs.themes.catppuccin;
       colorScheme = "mocha";
     };
}

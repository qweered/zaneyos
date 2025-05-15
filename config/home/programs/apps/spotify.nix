{ inputs, pkgs, ... }:
let
  spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    theme = spicetifyPkgs.themes.catppuccin;
    colorScheme = "mocha";
    #    enabledCustomApps = with spicetifyPkgs.apps; [
    #      marketplace
    #    ];
    enabledExtensions = with spicetifyPkgs.extensions; [
      adblock
      shuffle # shuffle+ (special characters are sanitized out of extension names)
      groupSession
      fullAlbumDate
      wikify
      songStats
      betterGenres
      lastfm
      beautifulLyrics
      #      keyboardShortcut
      #      popupLyrics
      #      seekSong
      #      skipStats
      #      playlistIntersection
      #      listPlaylistsWithSong
      # oneko # cat on the screen
    ];
  };
}

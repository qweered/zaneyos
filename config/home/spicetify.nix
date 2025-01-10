{ inputs, pkgs, ... }:

let
  spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify =
    {
      enable = true;
      enabledExtensions = with spicetifyPkgs.extensions; [
        adblock
        keyboardShortcut
        popupLyrics
        shuffle # shuffle+ (special characters are sanitized out of extension names)

        groupSession
        seekSong
        fullAlbumDate
        listPlaylistsWithSong
        playlistIntersection
        skipStats
        wikify
        songStats
        betterGenres
        lastfm
        beautifulLyrics
        # oneko - cat on the screen
      ];
      theme = spicetifyPkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
}

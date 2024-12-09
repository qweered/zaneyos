{ inputs, pkgs, ... }:
let
  spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.spicetify =
    {
      enable = true;
      enabledExtensions = with spicetifyPkgs.extensions; [
        adblock
        keyboardShortcut
        popupLyrics
        shuffle # shuffle+ (special characters are sanitized out of extension names)

        groupSession
        powerBar
        seekSong
        fullAppDisplayMod
        fullAlbumDate
        listPlaylistsWithSong
        playlistIntersection
        skipStats
        wikify
        songStats
        copyToClipboard
        history # Am i need this with lastfm?
        betterGenres
        lastfm
        beautifulLyrics
        oneko
      ];
      theme = spicetifyPkgs.themes.catpuccin;
      colorScheme = "mocha";
    };
}

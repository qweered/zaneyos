{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = false; # TODO:
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      jetbrains-mono # TODO: use correct name for jetbrains mono
      nerd-fonts.jetbrains-mono

      material-symbols
      nerd-fonts.symbols-only
    ];

    fontconfig = {
      allowBitmaps = false;
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Color Emoji"
        ];
        monospace = [
          "JetBrains Mono Nerd Font"
          "Noto Sans Mono"
          "Noto Color Emoji"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}

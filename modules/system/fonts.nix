{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      # icons
      material-symbols

      # sans-serif
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      roboto

      # monospace
      jetbrains-mono

      # nerd fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrains Mono Nerd Font" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}

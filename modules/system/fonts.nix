{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ kdePackages.breeze-icons ];

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
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
          "JetBrainsMono Nerd Font"
          "Noto Sans Mono"
          "Noto Color Emoji"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}

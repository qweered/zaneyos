{ pkgs, lib, ... }:

{
  # Font configuration for the system
  fonts = {
    packages = [
      # icon fonts
      pkgs.material-symbols

      # Sans(Serif) fonts
      pkgs.libertinus
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-emoji
      pkgs.roboto
      (pkgs.google-fonts.override { fonts = [ "Inter" ]; })

      # monospace fonts
      pkgs.jetbrains-mono

      # nerdfonts
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.symbols-only
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts =
      let
        addAll = lib.mapAttrs (_: v: v ++ [ "Noto Color Emoji" ]);
      in
      addAll {
        serif = [ "Libertinus Serif" ];
        sansSerif = [ "Inter" ];
        monospace = [ "JetBrains Mono Nerd Font" ];
        emoji = [ ];
      };
  };
}

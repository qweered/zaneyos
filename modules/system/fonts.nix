{ pkgs, lib, ... }:

{
  # TODO: recheck all this cause i stole from fufexan
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # Sans(Serif) fonts
      libertinus
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      (google-fonts.override { fonts = [ "Inter" ]; })

      # monospace fonts
      jetbrains-mono

      # nerdfonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
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

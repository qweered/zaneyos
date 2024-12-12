{
  imports = [
    # ./smartgaps.nix
  ];

  wayland.windowManager.hyprland.settings = {
    windowrulev2 =
      let
        f = regex: "float, class:^(${regex})$";
      in
      [
        (f "xdg-desktop-portal")
        (f "com.saivert.pwvucontrol")
        "float, title:^(Picture-in-Picture)$"
        "float, title:^(Bitwarden - Vivaldi)$"

        "suppressevent maximize, class:.*" # ignore maximizing requests from apps
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0" # fix dragging issues with XWayland
      ];
  };
}

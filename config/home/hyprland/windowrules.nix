{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 =
      let
        fc = regex: "float, class:^(${regex})$";
        ft = regex: "float, title:^(${regex})$";
        fct = class: title: "float, class:^(${class})$, title:^(${title})$";
      in
      [
        (fc "xdg-desktop-portal")
        (fc "com.saivert.pwvucontrol")
        (fc "com.github.wwmm.easyeffects")
        (fc "clipse")

        (fct "com.ayugram.desktop|io.github.kukuruzka165.materialgram" "Media viewer")

        (ft "Picture-in-Picture")
        (ft "Bitwarden - Vivaldi")

        "suppressevent maximize, class:.*" # ignore maximizing requests from apps
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0" # fix dragging issues with XWayland
      ];
  };
}

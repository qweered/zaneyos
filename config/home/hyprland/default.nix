{ pkgs, inputs, ... }:

let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in
{
  imports = [
    ./hyprstuff.nix
    ./windowrules.nix
    #    ./binds.nix
    #    ./decorations.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    settings = {

      exec-once = [
        "dunst"
      ];

      env = [
        "NIXOS_OZONE_WL,1" # use wayland in electron packages
        "MOZ_ENABLE_WAYLAND,1" # use wayland in firefox
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1" # disable window decorations
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "GDK_SCALE,1"
        "GDK_BACKEND,wayland,x11,*"
        "CLUTTER_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland" # QUIRK: Some games require it to be x11
      ];

      monitor = [
        "eDP-1, 1920x1080@65, 0x0, 1"
      ];

      general = {
        border_size = 5;
        # TODO: less/no border/gaps on floating, when multiple windows? See hyprand/smartgaps
        # no_border_on_floating = true;

        gaps_in = 10;
        gaps_out = 20;
        # gaps_workspaces = 3;

        "col.inactive_border" = "rgba(90,90,110,0.3) rgba(100,100,120,0.3) rgba(110,110,130,0.3) rgba(120,120,140,0.3) rgba(130,130,150,0.3) rgba(140,140,160,0.3) rgba(150,150,170,0.3) 45deg";
        "col.active_border" = "rgba(179,0,0,0.8) rgba(179,89,0,0.8) rgba(179,179,0,0.8) rgba(0,179,0,0.8) rgba(0,0,179,0.8) rgba(53,0,92,0.8) rgba(101,0,179,0.8) 45deg";
        # "col.nogroup_border" = 1;
        # "col.nogroup_border_active" = 1;

        allow_tearing = true;
        resize_on_border = true;

        # snap =  {
        #    enabled = true;
        # };
      };

      decoration = {
        rounding = 7;
        active_opacity = 1.0;
        # TODO: choose between dim and opacity for inactive windows
        #        inactive_opacity = 0.7;
        #        dim_inactive = true;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "wind,0.05,0.9,0.1,1.05" # Wind-like curve
          "winIn,0.1,1.1,0.1,1.1" # Smooth in
          "winOut,0.3,-0.3,0,1" # Smooth out with a bounce
          "liner,1,1,1,1" # Linear curve
          "overshot,0.05,0.9,0.1,1.05" # Overshooting effect
          "smoothOut,0.5,0,0.99,0.99" # Smooth out curve
          "smoothIn,0.5,-0.5,0.68,1.5" # Smooth in curve
        ];
        animation = [
          "windows,1,6,wind,slide" # Window animations using wind curve
          "windowsIn,1,5,winIn,slide" # Windows slide in with winIn curve
          "windowsOut,1,3,smoothOut,slide" # Windows slide out with smoothOut curve
          "windowsMove,1,5,wind,slide" # Window movement with wind curve
          "border,1,1,liner" # Border animation using linear curve
          "borderangle,1,180,liner,loop" # Rotating border animations
          "fade,1,3,smoothOut" # Fade animation with smoothOut curve
          "workspaces,1,5,overshot" # Workspace animation with overshooting curve
          "workspacesIn,1,5,winIn,slide" # Workspace slide in
          "workspacesOut,1,5,winOut,slide" # Workspace slide out
        ];
      };

      misc = {
        disable_splash_rendering = false;
        force_default_wallpaper = 1;
      };

      input = {
        kb_layout = "canary";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
        };
        sensitivity = 0;
        float_switch_override_focus = 2;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      #      bind = ${modifier},S,exec,screenshootin
      #      bind = ${modifier},P,pseudo,
      #      bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
      #      bind = ${modifier},SPACE,togglespecialworkspace
      #      bind = ${modifier}CONTROL,right,workspace,e+1
      #      bind = ${modifier}CONTROL,left,workspace,e-1
      #      bind = ${modifier},mouse_down,workspace, e+1
      #      bind = ${modifier},mouse_up,workspace, e-1
      #      bind = ALT,Tab,cyclenext
      #      bind = ALT,Tab,bringactivetotop
      bind =
        let
          binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
          mvfocus = binding "SUPER" "movefocus";
          ws = binding "SUPER" "workspace";
          resizeactive = binding "SUPER_CTRL" "resizeactive";
          mvactive = binding "SUPER_ALT" "moveactive";
          mvtows = binding "SUPER_SHIFT" "movetoworkspace";
          arr = [ 1 2 3 4 5 6 7 ];
        in
        [
          "SUPER, Return, exec, alacritty"
          "SUPER, B, exec, vivaldi"
          "SUPER_CTRL, RETURN, exec, rofi -show drun"

          "ALT, Tab, focuscurrentorlast"
          "CTRL_ALT, Delete, exit"
          "SUPER, Q, killactive"
          "SUPER, T, togglefloating"
          "SUPER, F, fullscreen"
          "SUPER, S, togglesplit"

          (mvfocus "k" "u")
          (mvfocus "j" "d")
          (mvfocus "l" "r")
          (mvfocus "h" "l")
          (ws "left" "e-1")
          (ws "right" "e+1")
          (mvtows "left" "e-1")
          (mvtows "right" "e+1")
          (resizeactive "k" "0 -20")
          (resizeactive "j" "0 20")
          (resizeactive "l" "20 0")
          (resizeactive "h" "-20 0")
          (mvactive "k" "0 -20")
          (mvactive "j" "0 20")
          (mvactive "l" "20 0")
          (mvactive "h" "-20 0")
        ]
        ++ (map (i: ws (toString i) (toString i)) arr)
        ++ (map (i: mvtows (toString i) (toString i)) arr);

      bindle = [
        ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
        ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
        # ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
        # ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
      ];

      bindl = [
        ",XF86AudioPlay,    exec, ${playerctl} play-pause"
        ",XF86AudioStop,    exec, ${playerctl} pause"
        ",XF86AudioPause,   exec, ${playerctl} pause"
        ",XF86AudioPrev,    exec, ${playerctl} previous"
        ",XF86AudioNext,    exec, ${playerctl} next"
        ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}

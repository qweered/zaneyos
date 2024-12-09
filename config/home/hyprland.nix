{ pkgs, inputs, ... }:

let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in
# TODO: add colors, add program variables
{
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
        "GDK_BACKEND,wayland"
        "CLUTTER_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland" # QUIRK: Some games require it to be x11
      ];

      monitor = [
        "eDP-1, 1920x1080@65, 0x0, 1"
      ];

      general = {
        gaps_in = 5; # TODO: Tweak gaps
        gaps_out = 20;
        # gaps_workspaces = 3;
        border_size = 5; # TODO: less border on floating?
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle"; # try master
        allow_tearing = true; # TODO: setup windowrules for games
        resize_on_border = true;

        # TODO: configure snap
      };

      decoration = {
        #        drop_shadow = true;
        rounding = 5;
        #        shadow_range = 8;
        #        shadow_render_power = 2;
        #        "col.shadow" = "rgba(00000044)";

        dim_inactive = false;

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
          "easeOutSmooth,0.25,0.8,0.5,1" # Smooth deceleration, for transitions with a more natural ease
          "easeInOutDynamic,0.6,0.1,0.4,0.9" # Dynamic in and out curve, adds both snappiness and fluidity
          "directQuick,0.3,0,0.7,1" # Quick but with a bit of easing, for rapid transitions
          "almostLinearSmooth,0.4,0.4,0.6,1" # Mostly linear, but with a touch of easing for fluidity
          "quickSmooth,0.15,0,0.25,1" # Fast, responsive curve but with a gentle start/finish
        ];

        animation = [
          "global, 1, 5, easeOutSmooth" # Global animations, smooth with slight deceleration
          "border, 1, 3.5, easeOutSmooth" # Border animations with a gentle, fluid easing
          "windows, 1, 3, easeInOutDynamic" # Windows animations, snappy but fluid both in and out
          "windowsIn, 1, 2.5, easeInOutDynamic, popin 87%" # Smooth and slightly faster window pop-in
          "windowsOut, 1, 2, directQuick, popin 87%" # Quick pop-out, fast but natural
          "fadeIn, 1, 1.7, almostLinearSmooth" # Fade-in animations, smooth with slight easing
          "fadeOut, 1, 1.5, almostLinearSmooth" # Fade-out animations with consistent smoothness
          "fade, 1, 2.5, quickSmooth" # General fades, responsive but fluid
          "layers, 1, 3, easeOutSmooth" # Layer animations with smooth easing
          "layersIn, 1, 2.8, easeOutSmooth, fade" # Layer entrance, smooth with fading
          "layersOut, 1, 2, directQuick, fade" # Fast but natural layer exit with fade
          "fadeLayersIn, 1, 1.8, almostLinearSmooth" # Smooth but quick fade-in for layers
          "fadeLayersOut, 1, 1.5, almostLinearSmooth" # Fade-out with fluid motion
          "workspaces, 1, 2.1, almostLinearSmooth, fade" # Workspace transitions, quick but smooth
          "workspacesIn, 1, 2, almostLinearSmooth, fade" # Workspace entrance, fluid fade
          "workspacesOut, 1, 2.1, almostLinearSmooth, fade" # Workspace exit, smooth with quick fade
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
          disable_while_typing = true;
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

      windowrule =
        let
          f = regex: "float, ^(${regex})$";
        in
        [
          (f "org.gnome.Nautilus")
          (f "nm-connection-editor")
          (f "blueberry.py")
          (f "Color Picker")
          (f "xdg-desktop-portal")
          (f "com.github.Aylur.ags")
          (f "Bitwarden - Vivaldi")
        ];

      # "Smart gaps" / "No gaps when only"
      # uncomment all if you wish to use that.
      #      workspace = [
      #        "w[t1], gapsout:0, gapsin:0"
      #        "w[tg1], gapsout:0, gapsin:0"
      #        "f[1], gapsout:0, gapsin:0"
      #      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*" # ignore maximizing requests from apps
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0" # fix dragging issues with XWayland
        # smart gaps
        #        "bordersize 0, floating:0, onworkspace:w[t1]"
        #        "rounding 0, floating:0, onworkspace:w[t1]"
        #        "bordersize 0, floating:0, onworkspace:w[tg1]"
        #        "rounding 0, floating:0, onworkspace:w[tg1]"
        #        "bordersize 0, floating:0, onworkspace:f[1]"
        #        "rounding 0, floating:0, onworkspace:f[1]"
      ];


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
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];


      #
      #      plugin = {
      #        overview = {
      #          centerAligned = true;
      #          hideTopLayers = true;
      #          hideOverlayLayers = true;
      #          showNewWorkspace = true;
      #          exitOnClick = true;
      #          exitOnSwitch = true;
      #          drawActiveWorkspace = true;
      #          reverseSwipe = true;
      #        };
      #        hyprbars = {
      #          bar_color = "rgb(2a2a2a)";
      #          bar_height = 28;
      #          col_text = "rgba(ffffffdd)";
      #          bar_text_size = 11;
      #          bar_text_font = "Ubuntu Nerd Font";
      #
      #          buttons = {
      #            button_size = 0;
      #            "col.maximize" = "rgba(ffffff11)";
      #            "col.close" = "rgba(ff111133)";
      #          };
      #        };
      #      };
    };
  };



  #      misc {
  #        mouse_move_enables_dpms = true
  #        key_press_enables_dpms = false
  #      }
  #      animations {
  #        enabled = yes
  #        bezier = wind, 0.05, 0.9, 0.1, 1.05
  #        bezier = winIn, 0.1, 1.1, 0.1, 1.1
  #        bezier = winOut, 0.3, -0.3, 0, 1
  #        bezier = liner, 1, 1, 1, 1
  #        animation = windows, 1, 6, wind, slide
  #        animation = windowsIn, 1, 6, winIn, slide
  #        animation = windowsOut, 1, 5, winOut, slide
  #        animation = windowsMove, 1, 5, wind, slide
  #        animation = border, 1, 1, liner
  #        animation = borderangle, 1, 30, liner, loop
  #        animation = fade, 1, 10, default
  #        animation = workspaces, 1, 5, wind
  #      }
  #      decoration {
  #        rounding = 10
  #        drop_shadow = false
  #        blur {
  #            enabled = true
  #            size = 5
  #            passes = 3
  #            new_optimizations = on
  #            ignore_opacity = on
  #        }
  #      }
  #      bind = ${modifier},Return,exec,${terminal}
  #      bind = ${modifier}SHIFT,Return,exec,rofi-launcher
  #      bind = ${modifier}SHIFT,W,exec,web-search
  #      bind = ${modifier}SHIFT,N,exec,swaync-client -rs
  #	  bind = ${modifier},W,exec,${browser}
  #      bind = ${modifier},S,exec,screenshootin
  #      bind = ${modifier},D,exec,discord
  #      bind = ${modifier}SHIFT,G,exec,godot4
  #      bind = ${modifier},T,exec,thunar
  #      bind = ${modifier},M,exec,spotify
  #      bind = ${modifier},Q,killactive,
  #      bind = ${modifier},P,pseudo,
  #      bind = ${modifier}SHIFT,I,togglesplit,
  #      bind = ${modifier},F,fullscreen,
  #      bind = ${modifier}SHIFT,F,togglefloating,
  #      bind = ${modifier}SHIFT,C,exit,
  #      bind = ${modifier}SHIFT,left,movewindow,l
  #      bind = ${modifier}SHIFT,right,movewindow,r
  #      bind = ${modifier}SHIFT,up,movewindow,u
  #      bind = ${modifier}SHIFT,down,movewindow,d
  #      bind = ${modifier}SHIFT,h,movewindow,l
  #      bind = ${modifier}SHIFT,l,movewindow,r
  #      bind = ${modifier}SHIFT,k,movewindow,u
  #      bind = ${modifier}SHIFT,j,movewindow,d
  #      bind = ${modifier},left,movefocus,l
  #      bind = ${modifier},right,movefocus,r
  #      bind = ${modifier},up,movefocus,u
  #      bind = ${modifier},down,movefocus,d
  #      bind = ${modifier},h,movefocus,l
  #      bind = ${modifier},l,movefocus,r
  #      bind = ${modifier},k,movefocus,u
  #      bind = ${modifier},j,movefocus,d
  #      bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
  #      bind = ${modifier},SPACE,togglespecialworkspace
  #      bind = ${modifier}CONTROL,right,workspace,e+1
  #      bind = ${modifier}CONTROL,left,workspace,e-1
  #      bind = ${modifier},mouse_down,workspace, e+1
  #      bind = ${modifier},mouse_up,workspace, e-1
  #      bindm = ${modifier},mouse:272,movewindow
  #      bindm = ${modifier},mouse:273,resizewindow
  #      bind = ALT,Tab,cyclenext
  #      bind = ALT,Tab,bringactivetotop
  #      bind = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
  #      bind = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  #      binde = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  #      bind = ,XF86AudioPlay, exec, playerctl play-pause
  #      bind = ,XF86AudioPause, exec, playerctl play-pause
  #      bind = ,XF86AudioNext, exec, playerctl next
  #      bind = ,XF86AudioPrev, exec, playerctl previous
  #      bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
  #      bind = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
}

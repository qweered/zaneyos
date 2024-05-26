{ pkgs, config, lib, inputs, host,... }:

let
  hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};

  yt = pkgs.writeShellScript "yt" ''
    notify-send "Opening video" "$(wl-paste)"
    mpv "$(wl-paste)"
  '';

  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  inherit (import ../../hosts/${host}/options.nix)
    browser cpuType gpuType
    keyboardLayout terminal;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # hyprplugins.hyprtrails
    ];

    settings = {
          exec-once = [
            "ags -b hypr"
#            "nm-applet --indicator" -- handled by ags
            "hyprctl setcursor Qogir 24"
            "swayidle -w timeout 720 'swaylock -f' timeout 800 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f -c 000000'"
          ];

          env = [
                "NIXOS_OZONE_WL,1"
                "NIXPKGS_ALLOW_UNFREE,1"
                "GDK_BACKEND,wayland"
                "CLUTTER_BACKEND,wayland"
                "SDL_VIDEODRIVER,wayland" # TODO: Some games require it to be x11
                "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
                "QT_AUTO_SCREEN_SCALE_FACTOR,1"
                "MOZ_ENABLE_WAYLAND,1"
          ];

          monitor = [
            "eDP-1, 1920x1080, 0x0, 1"
          ];

          general = {
            layout = "dwindle";
            resize_on_border = true;
          };

          misc = {
            disable_splash_rendering = true;
            force_default_wallpaper = 1;
          };

          input = {
            kb_layout = keyboardLayout;
            kb_options = "grp:alt_shift_toggle";
            follow_mouse = 1;
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
              drag_lock = true;
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
            # no_gaps_when_only = "yes";
          };

          gestures = {
            workspace_swipe = true;
          };

          windowrule = let
            f = regex: "float, ^(${regex})$";
          in [
            (f "org.gnome.Nautilus")
            (f "pavucontrol")
            (f "nm-connection-editor")
            (f "blueberry.py")
            (f "Color Picker")
            (f "xdg-desktop-portal")
            (f "com.github.Aylur.ags")
            (f "Bitwarden - Vivaldi")
            "workspace 7, title:Spotify"
          ];

          bind = let
            binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
            mvfocus = binding "SUPER" "movefocus";
            ws = binding "SUPER" "workspace";
            resizeactive = binding "SUPER CTRL" "resizeactive";
            mvactive = binding "SUPER ALT" "moveactive";
            mvtows = binding "SUPER SHIFT" "movetoworkspace";
            e = "exec, ags -b hypr";
            arr = [1 2 3 4 5 6 7];
          in
            [
              "CTRL SHIFT, R,  ${e} quit; ags -b hypr"
              "SUPER, R,       ${e} -t launcher"
              "SUPER, Tab,     ${e} -t overview"
              ",XF86PowerOff,  ${e} -r 'powermenu.shutdown()'"
              ",XF86Launch4,   ${e} -r 'recorder.start()'"
              ",Print,         ${e} -r 'recorder.screenshot()'"
              "SHIFT,Print,    ${e} -r 'recorder.screenshot(true)'"
              "SUPER, Return, exec, alacritty"
              "SUPER, W, exec, vivaldi"

              # youtube
              ", XF86Launch1,  exec, ${yt}"

              "ALT, Tab, focuscurrentorlast"
              "CTRL ALT, Delete, exit"
              "SUPER, Q, killactive"
              "SUPER, T, togglefloating"
              "SUPER, F, fullscreen"
              "SUPER, O, fakefullscreen"
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
            ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
            ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
            ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
            ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
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

          decoration = {
            drop_shadow = true;
            shadow_range = 8;
            shadow_render_power = 2;
            "col.shadow" = "rgba(00000044)";

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
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 5, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          plugin = {
            overview = {
              centerAligned = true;
              hideTopLayers = true;
              hideOverlayLayers = true;
              showNewWorkspace = true;
              exitOnClick = true;
              exitOnSwitch = true;
              drawActiveWorkspace = true;
              reverseSwipe = true;
            };
            hyprbars = {
              bar_color = "rgb(2a2a2a)";
              bar_height = 28;
              col_text = "rgba(ffffffdd)";
              bar_text_size = 11;
              bar_text_font = "Ubuntu Nerd Font";

              buttons = {
                button_size = 0;
                "col.maximize" = "rgba(ffffff11)";
                "col.close" = "rgba(ff111133)";
              };
            };
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
  };
}

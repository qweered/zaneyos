{ pkgs, ... }:

let
  app_runner = "rofi -show drun";
  browser = "vivaldi";
  terminal = "ghostty";
in
{
  wayland.windowManager.hyprland.settings = {

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
    binds = {
      allow_workspace_cycles = true;
    };

    bind =
      let
        binding =
          mod: cmd: key: arg:
          "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        ws = binding "SUPER" "workspace";
        resizeactive = binding "SUPER_CTRL" "resizeactive";
        mvactive = binding "SUPER_ALT" "moveactive";
        mvtows = binding "SUPER_SHIFT" "movetoworkspace";
        arr = [
          1
          2
          3
          4
          5
          6
          7
        ];
        # CONFIG: all pkgs.something should be declared somewhere else, lib.getexe?
        screenshot = pkgs.writeShellScript "screenshot" ''
          time=$(date +"%Y%m%d_%H%M%S")
          grim -g "$(slurp -b 1B1F28CC -c E06B74ff -s C778DD0D -w 2)" - | \
          satty --filename - --fullscreen \
            --output-filename "~/Pictures/Screenshots/Screenshot_$time.png" \
            --init-tool brush --copy-command wl-copy
        '';
      in
      [
        "SUPER, Return, exec, ${terminal}"
        "SUPER, V, exec, alacritty --class clipse -e 'clipse'"
        "SUPER, B, exec, ${browser}"
        "SUPER_CTRL, RETURN, exec, ${app_runner}"
        "SUPER, Print, exec, ${screenshot}"

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
      ",XF86MonBrightnessUp,   exec, brightnessctl set +5%"
      ",XF86MonBrightnessDown, exec, brightnessctl set  5%-"
      ",XF86AudioRaiseVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
      ",XF86AudioLowerVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
    ];

    bindl = [
      ",XF86AudioPlay,    exec, playerctl play-pause"
      ",XF86AudioStop,    exec, playerctl pause"
      ",XF86AudioPause,   exec, playerctl pause"
      ",XF86AudioPrev,    exec, playerctl previous"
      ",XF86AudioNext,    exec, playerctl next"
      ",XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
    ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}

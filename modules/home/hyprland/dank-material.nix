{ inputs, homeModulesPath, ... }:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    "${homeModulesPath}/programs/quickshell.nix"
  ];

  programs.dankMaterialShell = {
    enable = true;
    systemd.enable = true; # Systemd service for auto-start
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableVPN = true; # VPN management widget
    enableBrightnessControl = true; # Backlight/brightness controls
    enableColorPicker = true; # Color picker tool
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableSystemSound = true; # System sound effects
  };

}

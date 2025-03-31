{
  cfg,
  pkgs,
  ...
}:

{
  # CONFIG
  programs.neovide = {
    enable = true;
    settings = {
      fork = false;
      frame = "full";
      idle = true;
      maximized = false;
      neovim-bin = "/etc/profiles/per-user/${cfg.username}/bin/nvim";
      no-multigrid = false;
      srgb = false;
      tabs = true;
      theme = "auto";
      title-hidden = true;
      vsync = true;
      wsl = false;

      font = {
        normal = [ ];
        size = 14.0;
      };
    };
  };

  # CONFIG: https://notashelf.github.io/nvf/options
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
    };
  };

  programs = {
    # CONFIG
    fastfetch.enable = true;
    # CONFIG
    starship.enable = true;
  };

  # CONFIG
  # over mission-center (gui)
  programs.btop = {
    enable = true;
  };

  # CONFIG
  programs.zoxide = {
    enable = true;
  };
  # CONFIG
  services.playerctld.enable = true;
  # CONFIG
  services.mpd.enable = true;

  # CONFIG
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    scripts = [ pkgs.mpvScripts.mpris ];
  };
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  home.packages = with pkgs; [
    # CONFIG
    gdu # du alternative, over dua dust dutree pdu godu ncdu duc diskus
    eza # ls alternative, over exa, lsd
    duf # df alternative, over dysk (2 best) pydf di dfc dfrs
    wl-clipboard # over wl-clipboard-rs (broken)
    libnotify # send notifications programmatically
    grim
    slurp
    satty # over hyprshot swappy

    brightnessctl
    playerctl
    pulseaudio
    # try lazygit and lazydocker
    lazyjournal

    # Checked up to here

    # Hyprpanel dependencies
    hyprpicker
    #    swww

    # hyprpolkitagent
    # waypaper & hyprpaper in hm

    # Testing

    # programs.imv.enable = true; - image viewer, loupe?
    # programs.zathura.enable = true; - pdf viewer
    # wget
    #    wluma
    #    ripgrep
    #    procs # over ps aux
    #    bat # over cat
    #    zoxide
    # mc superfile xplr ranger lf nnn yazi broot
    # walker anyrun

    # Testing finished

    # activate-linux # windows watermark
    # discordchatexporter-cli # discord chat exporter
  ];
}

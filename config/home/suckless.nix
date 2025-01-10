{ cfg, inputs, pkgs, ... }:

{
  # TODO: configure https://tealdeer-rs.github.io/tealdeer/config_style.html
  programs.tealdeer = {
    enable = true;
    settings = {
      display = {
        compact = false;
        use_pager = false;
      };
      updates = {
        auto_update = true;
      };
    };
  };


  # TODO: configure
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

  # TODO: configure https://notashelf.github.io/nvf/options
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
    # TODO: configure
    fastfetch.enable = true;
    # TODO: configure
    starship.enable = true;
  };

  # TODO: configure
  # over mission-center (gui)
  programs.btop = {
    enable = true;
  };

  # TODO: configure
  programs.zoxide = {
    enable = true;
  };
  # TODO: configure
  services.playerctld.enable = true;
  # TODO: configure
  services.mpd.enable = true;

  # TODO: configure
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
    # TODO: configure
    gdu # du alternative, over dua dust dutree pdu godu ncdu duc diskus
    eza # ls alternative, over exa, lsd
    duf # df alternative, over dysk (best) pydf di dfc dfrs
    wl-clipboard # over wl-clipboard-rs (broken)
    libnotify # send notifications programmatically
    grim
    slurp
    satty # over hyprshot swappy
    brightnessctl
    # TODO: try lazygit and lazydocker
    lazyjournal

    # Checked up to here

    # Hyprpanel dependencies
    #    hyprpicker
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

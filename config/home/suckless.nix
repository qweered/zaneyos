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

  programs.anyrun = {
    enable = true;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        rink
        shell
        symbols
      ];

      width.fraction = 0.25;
      y.fraction = 0.3;
      layer = "overlay";
      hideIcons = false;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraConfigFiles = {
      "shell.ron".text = ''
        Config(
          prefix: ">"
        )
      '';

    };
  };


  # TODO: configure
  programs.neovide.enable = true;
  programs.neovide.settings = {
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

  #  programs.walker = {
  #    enable = true;
  #    runAsService = true;
  #
  #    # All options from the config.json can be used here.
  #    config = {
  #      search.placeholder = "Example";
  #      ui.fullscreen = true;
  #      list = {
  #        height = 200;
  #      };
  #      websearch.prefix = "?";
  #      switcher.prefix = "/";
  #    };
  #  };

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

  # programs.imv.enable = true; - image viewer, loupe?
  # programs.zathura.enable = true; - pdf viewer

  home.packages = with pkgs; [
    # TODO: configure
    wl-clipboard # over wl-clipboard-rs (broken)
    grim slurp satty # over hyprshot swappy
    clipse
    dunst # or mako? or other?
    brightnessctl
    # hyprpolkitagent
    # waypaper & hyprpaper in hm

    # TODO: try lazygit and lazydocker also
    lazyjournal

    # TODO: configure fonts properly
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji

    # TODO: configure
    eza # over exa, lsd
    wget

    # Testing
    hyprpicker
    activate-linux
    wluma
    ripgrep
    procs # over ps aux
    bat # over cat
    duf duff di dfc dfrs gdu dua dust ncdu
    # waybar? https://github.com/bjesus/wttrbar
    # zoxide
    # ranger lf nnn yazi
    # discordchatexporter-cli
  ];



  # home.file.".emoji".source = ./files/emoji;
  # home.file.".face.icon".source = ./files/face.jpg; # For SDDM


}

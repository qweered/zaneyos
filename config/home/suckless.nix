{ cfg, pkgs, ... }:

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

  # TODO: configure, and do i need mpd?
  services.playerctld.enable = true;
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
    rofi-wayland
    # TODO: configure
    dunst # or mako? or other?
    wl-clipboard
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
    # overskride
    # ranger lf nnn
    # discordchatexporter-cli;
  ];

  # home.file.".emoji".source = ./files/emoji;
  # home.file.".face.icon".source = ./files/face.jpg; # For SDDM
}

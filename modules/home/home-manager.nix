{ vars, ... }:

{
  imports = [
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/home-manager.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/quickshell.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/git.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/difftastic.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/patdiff.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/diff-highlight.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/diff-so-fancy.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/services/tldr-update.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/services/nix-gc.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/riff.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/delta.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/direnv.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/nh.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/fish.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/gh.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/jujutsu.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/services/window-managers/hyprland.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/nix-index.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/command-not-found"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/uv.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/services/mpd.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/services/playerctld.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/ssh.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/man.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/emacs.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/lazygit.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/gpg.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/services/gpg-agent.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/tealdeer.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/services/tldr-update.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/bat.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/ghostty.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/vim.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/starship.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/zoxide.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/mpv.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/rofi.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/yazi.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/vscode"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/neovim.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/opencode.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/bun.nix"
    "/nix/store/nn8i6b1d85clrdrla5qbs814kz4r0pyj-source/modules/programs/fastfetch.nix"
  ];

  programs.home-manager.enable = true;

  home = {
    inherit (vars) username stateVersion homeDirectory;
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1"; # for nix shell, nix run https://github.com/NixOS/nix/issues/9875
      EDITOR = "${vars.editor}";
      BROWSER = "${vars.browser}";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      NIXOS_OZONE_WL = "1"; # use wayland in electron packages
      MOZ_ENABLE_WAYLAND = "1"; # use wayland in firefox
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1"; # disable window decorations in qt apps
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      GDK_SCALE = "1";
      GDK_BACKEND = "wayland,x11,*";
      CLUTTER_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland"; # QUIRK: Some games require it to be x11
    };
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}

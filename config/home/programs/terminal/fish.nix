{ pkgs, ... }:

{
  home.packages = with pkgs; [ grc ];

  # CONFIG: https://www.reddit.com/r/NixOS/comments/1d174ds/how_can_i_get_colorful_man_pages/

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fastfetch
      set fish_greeting
    '';
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
    ];
    # TODO: for many of this i need not aliases but something that can replace installed programs
    shellAliases = {
      sys-switch = "nh os switch --ask";
      home-switch = "nh home switch --ask";
      sys-update = "nh os switch --update";
      sys-clean = "nh clean all";

      sv = "sudo neovide";
      v = "neovide";
      vim = "neovide";
      nvim = "neovide";
      exa = "eza";
      ls = "eza";
      ll = "eza -l";
      la = "eza -a";
      lal = "eza -al";
      ".." = "cd ..";
      "..." = "cd ../..";

      df = "duf";
      du = "gdu";
      ncdu = "gdu";
      htop = "btop";
      top = "btop";
      # "ps aux" = "procs";
    };
  };
}

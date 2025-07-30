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
    shellAliases = {
      nh-switch = "nh os switch --ask";
      nh-update = "nh os switch --update --ask";

      svi = "sudo nvim";
      ls = "eza";
      ll = "eza -l";
      la = "eza -a";
      lal = "eza -al";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      df = "duf";
      du = "gdu";
      htop = "btop";
      top = "btop";
      # "ps aux" = "procs"; TODO: add this
    };
  };
}

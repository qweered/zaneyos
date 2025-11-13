{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grc
    fishPlugins.grc
  ];
  # CONFIG: https://www.reddit.com/r/NixOS/comments/1d174ds/how_can_i_get_colorful_man_pages/

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fastfetch
    '';
    shellAliases = {
      nh-switch = "nh os switch --ask";
      nh-update = "nh os switch --update --ask";

      nix-develop = "nom develop";
      nix-build = "nom-build";
      nix-shell = "nom-shell";
      manix = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";

      svi = "sudo nvim";
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      ff = "fastfetch";
      df = "duf";
      du = "gdu";
      top = "btop";
      htop = "btop";
      rm = "rip --graveyard ~/.local/share/Trash";
      # "ps aux" = "procs"; TODO: add this
    };
  };
}

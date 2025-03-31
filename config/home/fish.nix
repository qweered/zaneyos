{ pkgs, cfg, ... }:

{
  home.packages = with pkgs; [ grc ];

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
      n-switch = "nh os switch --hostname ${cfg.hostname}";
      n-update = "nh os switch --hostname ${cfg.hostname} --update";
      n-clean = "nh clean all";
      sv = "sudo neovide";
      v = "neovide";
      ls = "eza";
      ll = "eza -l";
      la = "eza -a";
      lal = "eza -al";
      ".." = "cd ..";
    };
  };
}

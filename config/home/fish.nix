{ cfg, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fastfetch
      set fish_greeting
    '';
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

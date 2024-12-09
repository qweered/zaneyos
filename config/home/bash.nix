{ cfg, ... }:

{
  # TODO: replace with fish
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      fastfetch
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

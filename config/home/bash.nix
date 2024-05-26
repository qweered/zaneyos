{ config, lib, pkgs, host, ... }:

let inherit (import ../../hosts/${host}/options.nix) flakeDir flakePrev 
	     hostname flakeBackup theShell; in
lib.mkIf (theShell == "bash") {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
    '';
    initExtra = ''
      fastfetch
      if [ -f $HOME/.bashrc-personal ]; then
        source $HOME/.bashrc-personal
      fi
    '';
    sessionVariables = {
      FLAKEBACKUP = "${flakeBackup}";
      FLAKEPREV = "${flakePrev}";
    };
    shellAliases = {
      n-switch="nh os switch --hostname ${hostname}";
      n-update="nh os switch --hostname ${hostname} --update";
      n-clean="nh clean all";
      sv="sudo nvim";
      v="nvim";
      ls="lsd";
      ll="lsd -l";
      la="lsd -a";
      lal="lsd -al";
      ".."="cd ..";
    };
  };
}

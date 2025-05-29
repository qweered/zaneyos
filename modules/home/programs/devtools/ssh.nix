{
  # CONFIG: https://github.com/pjones/tilde/blob/4dc50f423d289c61784dbb4e8db6657229cc84ba/home/programs/ssh.nix#L4
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
}

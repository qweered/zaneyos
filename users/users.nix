{ pkgs, cfg, ... }:

{
  users.users = {
    "${cfg.username}" = {
      isNormalUser = true;
      initialPassword = "${cfg.username}";
      # description = "${gitUsername}"; TODO: setup description
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "audio" "video" ];
      shell = pkgs.bash;
    };
  };
}

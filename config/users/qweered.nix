{ pkgs, cfg, ... }:

{
  users = {
    defaultUserShell = pkgs.fish;
    users = {
      "${cfg.username}" = {
        isNormalUser = true;
        initialPassword = "password";
        description = "${cfg.description}";
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "audio"
          "video"
          "docker"
        ];
      };
    };
  };
}

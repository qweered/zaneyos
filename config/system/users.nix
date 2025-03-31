{ pkgs, cfg, ... }:

{
  users = {
    defaultUserShell = pkgs.fish;
    users = {
      "${cfg.username}" = {
        isNormalUser = true;
        initialPassword = "${cfg.username}";
        description = "${cfg.description}";
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "audio"
          "video"
        ];
        useDefaultShell = true;
      };
    };
  };
}

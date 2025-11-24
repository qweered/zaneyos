{
  inputs,
  specialArgs,
  pkgs,
  ...
}:

let
  vars = rec {
    username = "qweered";
    homeDirectory = "/home/${username}";
    description = "The only and the greatest admin";
    browser = "vivaldi";
    editor = "nvim";
    stateVersion = "24.11"; # Change it when i read all changelogs from previous versions and make changes
  };
in

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = specialArgs // {
      inherit vars;
    };
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users."${vars.username}".imports = inputs.self.moduleTree.home { hyprland.smartgaps = false; };
  };

  users = {
    mutableUsers = true; # need agenix password for false
    defaultUserShell = pkgs.fish;
    users = {
      "${vars.username}" = {
        isNormalUser = true;
        initialPassword = "password";
        inherit (vars) description;
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "audio"
          "video"
          "input"
          "podman"
          "adbusers"
        ];
      };
    };
  };
}

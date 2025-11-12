{
  pkgs,
  inputs,
  pkgs-master,
  pkgs-stable,
  ...
}:

let
  vars = {
    username = "qweered";
    homeDirectory = "/home/qweered";
    city = "Vilnius"; # TODO: find a way to get this based on location, also does not work currently
    description = "The only and the greatest admin";
    browser = "vivaldi";
    stateVersion = "24.11"; # Change it when i read all changelogs from previous versions and make changes
  };
in

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        vars
        pkgs-master
        pkgs-stable
        ;
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
          "podman"
        ];
      };
    };
  };
}

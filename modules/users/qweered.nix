{
  pkgs,
  inputs,
  config,
  pkgs-master,
  pkgs-stable,
  ...
}:
let
  hostname = config.networking.hostName;
  vars = {
    username = "qweered";
    city = "Vilnius"; # TODO: found a way to get this based on location
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
        hostname # TODO: maybe there is a better way to do this
        ;
    };
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users."${vars.username}".imports = inputs.self.moduleTree.home {
      apps.socials.teams = false;
      apps.socials.zoom = false;
      devtools.windsurf = false;
      hyprland.smartgaps = false;
    };
  };

  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.fish;
    users = {
      "${vars.username}" = {
        isNormalUser = true;
        initialPassword = "password";
        description = vars.description;
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

{
  pkgs,
  inputs,
  lib,
  pkgs-master,
  pkgs-stable,
  pkgs-review,
  ...
}:
let
  vars = {
    username = "qweered";
    city = "Vilnius"; # TODO: find a way to get this based on location
    description = "The only and the greatest admin";
    browser = "vivaldi";
    stateVersion = "24.11"; # Change it when i read all changelogs from previous versions and make changes
    
    # Git configuration
    git = {
      userName = "Aliaksandr";
      userEmail = "grubian2@gmail.com";
      githubUser = "qweered";
      signingKey = "CACB28BA93CE71A2";
    };
  };
in
{
  # Basic validation
  assertions = [
    {
      assertion = vars.git.userEmail != "" && lib.hasInfix "@" vars.git.userEmail;
      message = "Git email must be a valid email address";
    }
    {
      assertion = vars.git.signingKey != "";
      message = "Git signing key must be provided";
    }
    {
      assertion = vars.username != "";
      message = "Username cannot be empty";
    }
  ];
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        vars
        pkgs-master
        pkgs-stable
        pkgs-review
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

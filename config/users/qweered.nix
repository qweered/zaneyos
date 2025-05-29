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
    city = "Vilnius"; # TODO: found a way to get this based on location
    description = "The only and the greatest admin";
    browser = "vivaldi";
    stateVersion = "24.11"; # Change it when i read all changelogs from previous versions and make changes
  };
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  # TODO: test if multiusers work (i think it doesn't)

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        vars
        pkgs
        pkgs-master
        pkgs-stable
        ;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      "${vars.username}" = import ../home;
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

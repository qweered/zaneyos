{
  inputs,
  cfg,
  pkgs-master,
  ...
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      # WARN: if i import config it breaks, why?
      inherit inputs cfg pkgs-master;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.${cfg.username} = import ../home;
  };
}

{ inputs, config, username, host, ... }:
let 
  inherit (import ./../hosts/${host}/options.nix)
    gitUsername gitEmail version;
in {
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.hyprland.homeManagerModules.default
    inputs.nur.hmModules.nur
    ./../config/home
  ];

  news.display = "show";

  programs.git = {
    enable = true;
#    extraConfig = {
#          color.ui = true;
#          core.editor = "nvim";
#          credential.helper = "store";
#          push.autoSetupRemote = true;
#    };
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  xdg = {
    userDirs = {
        enable = true;
        createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = version;
}

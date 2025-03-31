{ pkgs, ... }:
{
  # CONFIG
  # Configure global git-hooks?
  programs.git = {
    enable = true;
    userName = "qweered";
    userEmail = "grubian2@gmail.com";
    delta.enable = true;
    #    signing = {};
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      # CONFIG: replace with gpg
      credential.helper = "manager";
      credential."https://github.com".username = "qweered";
      credential.credentialStore = "cache";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };

  home.packages = with pkgs; [
      git-credential-manager
  ];

  # programs.git-credential-oauth.enable = true;
  # over git-credential-manager (-70mb) but i can't get it to work
}

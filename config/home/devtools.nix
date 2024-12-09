{ cfg, pkgs, ... }:

{
  # TODO: setup gpg signing and other things
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "manager";
      credential."https://github.com".username = "${cfg.gitUsername}";
      credential.credentialStore = "cache";
      push.autoSetupRemote = true;
    };
    userName = "${cfg.gitUsername}";
    userEmail = "${cfg.gitEmail}";
  };

  home.packages = with pkgs; [
    git-credential-manager
  ] ++ [
    jetbrains-toolbox # TODO: possibly move to separate packages
    code-cursor
  ] ++ [
    nodejs # TODO: how to use different versions?
  ];

  programs.bun.enable = true;
}

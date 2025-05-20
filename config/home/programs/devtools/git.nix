{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal.override { withLibsecret = true; }; # gitMinimal to remove perl
    userName = "Aliaksandr";
    userEmail = "grubian2@gmail.com";
    delta.enable = true;
    aliases = {
      ci = "commit";
      co = "checkout";
      b = "branch -vv";
      s = "status --short";
      ds = "describe --long --tags --dirty --always";
      lg = "log --pretty=format:'%Cgreen%h%Creset %Cred%cd%Creset %Cblue%ae%Creset %s %d'";
      sb = "submodule";
      sbu = "submodule update --init --recursive";
      sbp = "submodule update --remote --checkout";
      unstage = "reset head --";
    };
    signing = {
      key = "CACB28BA93CE71A2";
      signByDefault = true;
    };
    extraConfig = {
      color.ui = true;
      color.pager = true;
      core.editor = "nvim";
      credential.helper = "libsecret";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      # branch.autoSetupRebase = "always";
      # push.default = "simple";
      rerere.enable = true;
      gc.reflogExpire = "1 year";
      gc.rerereResolved = "1 year";
      github.user = "qweered";
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
        "https://gitlab.com/" = {
          insteadOf = [
            "gl:"
            "gitlab:"
          ];
        };
      };
    };
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-qt; # gnome does not work
  };
}

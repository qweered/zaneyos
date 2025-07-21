{ pkgs, vars, ... }:
{
  programs.gpg = {
    enable = true;
    settings = {
      default-key = vars.git.signingKey;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-qt; # TODO: gnome does not work
  };
}

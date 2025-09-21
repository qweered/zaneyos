{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "CACB28BA93CE71A2";
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-qt; # TODO: gnome does not work
  };
}

{ config, host, lib, ... }:

let
   inherit (import ../../hosts/${host}/options.nix) username;
in
{
  programs.regreet.enable = true;
  services.libinput.enable = true;
  services.greetd = let
    session = {
      command = "${lib.getExe config.programs.hyprland.package}";
      user = "${username}";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
#      initial_session = session;
    };
  };

  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}
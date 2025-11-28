{
  security.pam.services = {
    login.enableGnomeKeyring = true;
    sddm.enableGnomeKeyring = true; # NOTE: workaround for https://github.com/NixOS/nixpkgs/issues/86884
  };
}

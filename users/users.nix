{ pkgs, config, username, host, ... }:

let
  inherit (import ./../hosts/${host}/options.nix) theShell;
in {
  users.users = {
    "${username}" = {
      isNormalUser = true;
      initialPassword = "${username}";
      # description = "${gitUsername}"; TODO: setup description
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "audio" "video" ];
      shell = pkgs.${theShell};
    };

    # Add users here
  };
}

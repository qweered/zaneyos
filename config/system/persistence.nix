{ config, pkgs, lib, username, host, ... }:

let 
  inherit ( import ../../hosts/${host}/options.nix ) username;
in
{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/egnutartc/NetworkManager/system-connections"
    ];
    files = [
      # "/etc/machine-id"
    ];
    users.${username} = {
      directories = [
	"Downloads"
	"Music"
	"Documents"
	"Pictures"
        "Videos"
        "zaneyos"
	".local/share/sddm"
	".mozilla"
	".cache"
	".ssh"
#	".steam"
      ];
      files = [
      ];
    };
  };
}

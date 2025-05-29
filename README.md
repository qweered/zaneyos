* Replace credentials in config/home/git.nix
* Add your system configuration to config/hosts (see my in config/hosts/hyprnix)
* Add access-token in config/system/nix.nix

## How to find dependencies

nix-tree

❯ nix-store --query --referrers /nix/store/z8z1mhfnvw40dwljqazxv0343sv5ds2g-git-2.49.0/


❯ nix-store --query --references /nix/store/z8z1mhfnvw40dwljqazxv0343sv5ds2g-git-2.49.0/
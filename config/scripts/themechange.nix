{ pkgs, host, ... }:

let 
  inherit (import ../../hosts/${host}/options.nix) flakeDir hostname terminal;
in
pkgs.writeShellScriptBin "themechange" ''
  if [[ ! $@ ]];then
    echo "No Theme Given"
  else
    replacement="$1"
    sed -i "/^\s*theme[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$replacement\"/" ${flakeDir}/hosts/${host}/options.nix
    ${terminal} -e nh os switch
  fi
''

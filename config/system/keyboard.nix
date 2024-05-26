{host, ...}:

let inherit (import ../../hosts/${host}/options.nix) keyboardLayout; in
{
  services.xserver = {
    xkb = {
      layout = "${keyboardLayout}";
      extraLayouts.canary = {
        description = "canary";
	    languages = [ "eng" ];
	    symbolsFile = /home/qweered/zaneyos/assets/keyboard/canary;
      };
    };
  };
  console.useXkbConfig = true;
}
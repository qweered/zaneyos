# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options

let
  setUsername = "qweered";
  setHostname = "hyprnix";
in {
  username = "${setUsername}";
  hostname = "${setHostname}";
  userHome = "/home/${setUsername}";
  flakeDir = "/home/${setUsername}/zaneyos";
  wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git"; # Can be changed IF you know what your doing
  wallpaperDir = "/home/${setUsername}/Pictures/Wallpapers";
  screenshotDir = "/home/${setUsername}/Pictures/Screenshots";
  flakePrev = "/home/${setUsername}/.zaneyos-previous";
  flakeBackup = "/home/${setUsername}/.zaneyos-backup";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "qweered";
  gitEmail = "grubian2@gmail.com";

  # Waybar Settings
  bar-number = true; # Enable / Disable Workspace Numbers In Waybar

  # System Settings
  clock24h = false;
  userLocale = "ru_RU.UTF-8/UTF-8";
  keyboardLayout = "canary";
  timeZone = "Europe/Vilnius";

  theShell = "bash"; # Possible options: bash, zsh
  kernel = "zen";

  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "amd";
  gpuType = "amd";

  # Nvidia Hybrid Devices ONLY NEEDED FOR HYBRID SYSTEMS! 
  intel-bus-id = "PCI:1:0:0";
  nvidia-bus-id = "PCI:0:2:0";

  # Enable / Setup NFS
#  nfs = false;
#  nfsMountPoint = "/mnt/nas";
#  nfsDevice = "nas:/volume1/nas";

  browser = "vivaldi";
  terminal = "alacritty";
  version = "23.11";
#  distrobox = false;
#  printer = false;
  flatpak = false;
}

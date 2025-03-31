{ pkgs, ... }:

{
  #  security.unprivilegedUsernsClone = true; # Required for hardened kernel
    services.scx.enable = true; # Probably corrupts audio ?
  # CONFIG: enably cachy ananicy rules

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    tmp.cleanOnBoot = true;

    # CONFIG: Not feature-complete yet https://blog.decent.id/post/nixos-systemd-initrd/
    # initrd.systemd.enable = true;

    kernelPackages = pkgs.linuxPackages_latest;

    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      # CONFIG: replace with my own theme
      themePackages = [ pkgs.nixos-bgrt-plymouth ];
    };

    # Silent boot
    initrd.verbose = false;
    consoleLogLevel = 0;
    # CONFIG: configure more parameters
    kernelParams = [
      "quiet"
      "splash"
      "vt.global_cursor_default=0"
      "loglevel=3"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      "boot.shell_on_fail"
    ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    loader.timeout = 0;
  };
}

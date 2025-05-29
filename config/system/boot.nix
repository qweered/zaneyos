{ pkgs, inputs, ... }:

{
  imports = [ inputs.chaotic.nixosModules.default ];

  services.scx.enable = true;
  # CONFIG: enable cachy ananicy rules https://www.nyx.chaotic.cx/

  # security.unprivilegedUsernsClone = true; # Required for hardened kernel

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    tmp.cleanOnBoot = true;

    # CONFIG: Not feature-complete yet https://blog.decent.id/post/nixos-systemd-initrd/
    initrd.systemd.enable = true;

    kernelPackages = pkgs.linuxPackages_cachyos;

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
      "microcode.amd_sha_check=off" # for ucodenix to work properly
      "clocksource=tsc" # always tsc even it may be not reliable
      "tsc=reliable"
    ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    loader.timeout = 0;
  };
}

{ pkgs, ... }:

{
  security.unprivilegedUsernsClone = true; # Required for hardened kernel
  services.scx.enable = true;
  # TODO: enably cachy ananicy rules

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    tmp.cleanOnBoot = true;
    # initrd.systemd.enable = true; # TODO: Not feature-complete yet https://blog.decent.id/post/nixos-systemd-initrd/

    kernelPackages = pkgs.linuxPackages_latest; # TODO: evaluate switching to hardened when using nix-mineral

    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      # TODO: replace with my own theme
      themePackages = [ pkgs.nixos-bgrt-plymouth ];
    };

    # Silent boot
    initrd.verbose = false;
    consoleLogLevel = 0;
    # TODO: configure more parameters
    kernelParams = [
      "quiet"
      "splash"
      "vt.global_cursor_default=0"
      "loglevel=3"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "plymouth.use-simpledrm"

      "boot.shell_on_fail"
    ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };
}

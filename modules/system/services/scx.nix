{ pkgs, ... }:

{
  # sched-ext schedulers
  services.scx = {
    enable = true;
    package = pkgs.scx.rustscheds;
    scheduler = "scx_lavd";
  };
}

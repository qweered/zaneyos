{ pkgs, ... }:
{
  # over pavucontrol, pulsemixer
  home.packages = with pkgs; [ pwvucontrol ];
}

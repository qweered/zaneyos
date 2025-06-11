{ pkgs-review, ... }:
{
  home.packages = with pkgs-review; [ code-cursor ];
}

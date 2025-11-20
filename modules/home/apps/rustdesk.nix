{ pkgs, ... }:
{
  # over anydesk, teamviewer
  home.packages = [ pkgs.rustdesk ];
}

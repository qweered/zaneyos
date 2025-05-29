{ pkgs, ... }:
{
  # over anydesk, teamviewer
  home.packages = with pkgs; [ rustdesk-flutter ];
}

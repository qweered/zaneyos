{ pkgs, ... }:
{
  # over libreoffice, onlyoffice-desktopeditors
  # TODO: should be wpsoffice cause libreoffice adds 1.7 gb to storage
  home.packages = [ pkgs.libreoffice ];
}

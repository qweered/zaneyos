{ pkgs, ... }:
{
  # over libreoffice-qt-fresh (adds kde bloat), onlyoffice-desktopeditors
  # TODO: should be wpsoffice cause libreoffice adds 1.7 gb to storage
  home.packages = [ pkgs.libreoffice-fresh ];
}

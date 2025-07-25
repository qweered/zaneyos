{ pkgs-master, ... }:
{
  home.packages = with pkgs-master; [
    (vivaldi.override {
      enableWidevine = true;
      inherit widevine-cdm;
      # Proprietary codecs are broken
      # proprietaryCodecs = true;
      # inherit vivaldi-ffmpeg-codecs;
    })
  ];
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (vivaldi.override {
      enableWidevine = true;
      inherit widevine-cdm;
      # Proprietary codecs are broken now
      # proprietaryCodecs = true;
      # inherit vivaldi-ffmpeg-codecs;
    })
  ];
}

{ pkgs-master, ... }:
{
  home.packages = with pkgs-master; [
    (vivaldi.override {
      proprietaryCodecs = true;
      inherit vivaldi-ffmpeg-codecs;

      enableWidevine = true;
      inherit widevine-cdm;
    })
  ];
}

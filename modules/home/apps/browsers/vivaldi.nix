{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (vivaldi.override {
      proprietaryCodecs = true;
      inherit vivaldi-ffmpeg-codecs;

      enableWidevine = true;
      inherit widevine-cdm;
    })
  ];
}

{ pkgs, ... }:

let
  json = pkgs.formats.json { };

  pw_rnnoise_config = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "args" = {
          "node.description" = "Noise Canceling source";
          "media.name" = "Noise Canceling source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                "label" = "noise_suppressor_stereo";
                "control" = {
                  "VAD Threshold (%)" = 50.0;
                };
              }
            ];
          };
          "audio.position" = [
            "FL"
            "FR"
          ];
          "capture.props" = {
            "node.name" = "effect_input.rnnoise";
            "node.passive" = true;
          };
          "playback.props" = {
            "node.name" = "effect_output.rnnoise";
            "media.class" = "Audio/Source";
          };
        };
      }
    ];
  };
in
{
  xdg.configFile."pipewire/pipewire.conf.d/99-input-denoising.conf" = {
    source = json.generate "99-input-denoising.conf" pw_rnnoise_config;
  };
}

# Stolen from fufexan https://github.com/fufexan/dotfiles/blob/17939d902a780a6db459312baa40940ff2a9c149/home/programs/media/rnnoise.nix#L1C1-L41C2

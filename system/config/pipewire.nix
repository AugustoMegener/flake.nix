{ ... }:
{

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

services.pipewire.extraConfig.pipewire."91-audiorelay" = {
  "context.objects" = [
    {
      factory = "adapter";
      args = {
        "factory.name" = "support.null-audio-sink";
        "node.name" = "system_capture_sink";
        "node.description" = "System Audio Capture";
        "media.class" = "Audio/Sink";
        "audio.position" = [ "FL" "FR" ];
      };
    }
  ];
  "context.modules" = [
    {
      name = "libpipewire-module-loopback";
      args = {
        "audio.position" = [ "FL" "FR" ];
        "capture.props" = {
          "media.class" = "Audio/Sink";
          "node.name" = "audiorelay_out";
          "node.description" = "AudioRelay Output";
        };
        "playback.props" = {
          "media.class" = "Stream/Output/Audio";
          "node.name" = "audiorelay_out_playback";
          "node.description" = "AudioRelay Output Playback";
        };
      };
    }
    {
      name = "libpipewire-module-loopback";
      args = {
        "node.description" = "AudioRelay Mic";
        "capture.props" = {
          "node.name" = "audiorelay_mic";
          "media.class" = "Audio/Source";
          "target.object" = "audiorelay_out";
          "stream.capture.sink" = true;
        };
      };
    }
    {
      name = "libpipewire-module-loopback";
      args = {
        "node.description" = "System Audio Capture Feed";
        "capture.props" = {
          "node.name" = "system_audio_capture_in";
          "target.object" = "@DEFAULT_SINK@";
          "stream.capture.sink" = true;
        };
        "playback.props" = {
          "node.name" = "system_audio_capture_out";
          "target.object" = "system_capture_sink";
        };
      };
    }
  ];
};

  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
    };
  };
}

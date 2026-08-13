{ inputs, ... }:
{
  home.packages = [
    inputs.audiorelay.packages.x86_64-linux.audio-relay
  ];
}

{ config, pkgs, ... }:
{
  programs.obs-studio.enable = true;

  home.packages = with pkgs; [
    obs-cli
  ];

  xdg.desktopEntries.obs = {
    name = "OBS Studio";
    exec = "obs";
    icon = "obs";
    type = "Application";
    categories = [ "AudioVideo" "Recorder" ];
  };
}

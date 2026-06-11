{ pkgs, ... }:
{
  programs.obs-studio.enable = true;
  packages = with pkgs; [
    obs-cli
  ];
}

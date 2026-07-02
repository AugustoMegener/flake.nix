{ config, pkgs, ... }:
{
  programs.obs-studio.enable = true;

  home.packages = with pkgs; [
    obs-cli
  ];

 xdg.systemDirs.data = [ "${pkgs.obs-studio}/share" ];
}

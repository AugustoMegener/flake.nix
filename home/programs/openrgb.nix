
{ config, pkgs, ... }:
{
  programs.openrgb.enable = true;
  services.udev.packages = [ pkgs.openrgb ];

}

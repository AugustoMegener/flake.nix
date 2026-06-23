
{ config, pkgs, ... }:
{
services.udev.packages = [ pkgs.openrgb ];
environment.systemPackages = [ pkgs.openrgb ];

}

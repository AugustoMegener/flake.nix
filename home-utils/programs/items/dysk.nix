{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    dysk
  ];
}

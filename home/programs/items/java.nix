{ pkgs, ... }:
{
  home.packages = with pkgs; [ gradle jdk jdk21 ];
}

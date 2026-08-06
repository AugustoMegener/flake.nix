{ pkgs, ... }:
{
  home.packages = with pkgs; [ gradle jdk jdk21   (lib.lowPrio pkgs.jdk17) ];
}

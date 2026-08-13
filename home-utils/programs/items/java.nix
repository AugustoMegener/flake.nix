{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ gradle jdk ];


  home.activation.gradleJdk = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.gradle/jdks
    ln -sfn ${pkgs.jdk21} $HOME/.gradle/jdks/jdk-21
    ln -sfn ${pkgs.jdk17} $HOME/.gradle/jdks/jdk-17
  '';
}

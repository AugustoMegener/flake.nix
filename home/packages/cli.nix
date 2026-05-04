{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wget
    unzip
    curl
    fastfetch
    p7zip
  ];
}

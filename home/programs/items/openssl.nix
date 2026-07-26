{ pkgs, ... }:
{
  home.packages = [ pkgs.openssl.dev ];
}

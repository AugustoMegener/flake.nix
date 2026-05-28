{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.nixvim-config.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}

{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.bolchevim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}

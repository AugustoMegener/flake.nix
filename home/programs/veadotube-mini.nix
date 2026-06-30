{ inputs, ... }:
{
  home.packages = [
    inputs.veadotube-mini.packages.x86_64-linux.veadotube-mini
  ];
}

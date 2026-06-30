{ inputs, ... }:
{
  home.packages = [
    input.veadotube-mini.packages.x86_64-linux.flashpoint
  ];
}

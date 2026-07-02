{ inputs, ... }:
{
  home.packages = [
    inputs.flashpoint.packages.x86_64-linux.flashpoint
  ];
}

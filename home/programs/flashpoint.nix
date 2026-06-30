{ inputs, ... }:
{
  home.packages = [
    input.flashpoint.packages.x86_64-linux.flashpoint
  ];
}

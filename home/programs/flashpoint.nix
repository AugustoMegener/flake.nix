{ inputs, ... }:
{
  environment.systemPackages = [
    inputs.flashpoint.packages.x86_64-linux.flashpoint
  ];
}

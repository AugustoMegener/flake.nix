{ inputs, ... }: 
{
  home.packages = [ inputs.hytale-launcher.packages.x86_64-linux.default  ];
}

{
    inputs,
    ...
}:
{
  imports = [
    ./programs
    inputs.home-utils.homeModules.default
  ];

  programs.home-manager.enable = true;

  home.username = "kito";
  home.homeDirectory = "/home/kito";
  home.stateVersion = "25.05";
}

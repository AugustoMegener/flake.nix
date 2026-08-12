{
    inputs,
    ...
}:
{
  imports = [
    ./scripts
    ./programs
    inputs.desktop.homeModules.default
  ];

  home.username = "kito";
  home.homeDirectory = "/home/kito";
  home.stateVersion = "25.05";

  home.sessionVariables.TERMINAL = "kitty";

  programs.home-manager.enable = true;
}

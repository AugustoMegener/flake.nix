{
    config,
    pkgs,
    lib,
    inputs,
    ...
}:
{
imports = [
 ./scripts
  ./programs
  ./xdg
  inputs.hyprland-config.homeModules.default
  ./swaync/config.nix
];



  home.username = "kito";
  home.homeDirectory = "/home/kito";
  home.stateVersion = "25.05";

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk4 = {
      enable = true;

      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };
  };



  programs.home-manager.enable = true;


  qt.enable = true;
  home.packages = [ inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}

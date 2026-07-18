{
    config,
    pkgs,
    lib,
    inputs,
    ...
}:
{
imports = [
  ./packages
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

  home.activation.gradleJdk = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.gradle/jdks
    ln -sfn ${pkgs.jdk21} $HOME/.gradle/jdks/jdk-21
    '';

  qt.enable = true;
  home.packages = [ inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}

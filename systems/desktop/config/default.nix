{ pkgs, ... }:
{
  imports = [
    ./hyprland
    ./xdg
    ./programs-styles
    ./swaync
  ];

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

  qt.enable = true;
}

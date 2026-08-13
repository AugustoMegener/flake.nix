{ pkgs, ... }:
{

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GTK_THEME = "Adwaita";
    };

    shells = [ pkgs.zsh ];

    variables.EDITOR = "nvim";

    systemPackages = with pkgs; [ 
      direnv
      mesa-demos
      brightnessctl
      xdg-desktop-portal
      openrgb
      alsa-plugins
    ];
  };
}

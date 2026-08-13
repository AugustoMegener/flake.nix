{ pkgs, ... }:
{
  services = { 
    blueman.enable = true;

    libinput.enable = true;

    displayManager.defaultSession = "hyprland";

    flatpak.enable = true; 

    dbus.packages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
    ];

    openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        PubkeyAuthentication = true;
      };
    }; 
  };
}

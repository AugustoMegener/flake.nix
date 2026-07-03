{ pkgs, ... }:
{
  imports = [
    ./hyprpaper.nix
    ./hyprcursor.nix
    ./window-manager.nix
    ./monitors.nix
    ./autostart.nix
    ./environment.nix
    ./appearance.nix
    ./input.nix
    ./keybinds.nix
    ./rules.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = with pkgs; [
    hyprshutdown
    inputs.bolcshell.packages.${pkgs.system}.default
  ];
}

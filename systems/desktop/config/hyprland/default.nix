{ pkgs, ... }:
{
  imports = [
    ./keybinds
    ./window-rules
    ./hypr-dynamic-cursors
    ./environment
    ./appearance
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprcursor.nix
    ./monitors.nix
    ./autostart.nix
    ./input.nix
  ];

  home.packages = with pkgs; [
    hyprshutdown
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
  };
}

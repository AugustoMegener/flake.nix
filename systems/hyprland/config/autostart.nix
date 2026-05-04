{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "swaync"
      "waybar & obsidian &"
      "systemd-run --user --scope --slice=app elephant"
      "walker --gapplication-service"
     "/usr/lib/xdg-desktop-portal-hyprland"
    ];
  };
}

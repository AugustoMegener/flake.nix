{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "bolcshell --daemonize" 
      "swaync"
      "obsidian &"
      "systemd-run --user --scope --slice=app elephant"
      "walker --gapplication-service"
     "/usr/lib/xdg-desktop-portal-hyprland"
    ];
  };
}

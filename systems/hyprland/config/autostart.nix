{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "/usr/lib/xdg-desktop-portal-hyprland"
      "bolcshell --daemonize" 
      "swaync"
      "obsidian &"
      "sleep 5; systemd-run --user --scope --slice=app elephant"
      "walker --gapplication-service"
    ];
  };
}

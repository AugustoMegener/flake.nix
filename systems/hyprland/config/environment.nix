{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_SIZE,12"
      "HYPRCURSOR_SIZE,12"
      "GTK_THEME,Adwaita:dark"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    ecosystem {
      enforce_permissions = 1
    }

    permission = .*/grim, screencopy, allow
    permission = .*/xdg-desktop-portal-hyprland, screencopy, allow
    permission = .*/hyprpm, plugin, allow
    permission = .*/hyprshot, screencopy, allow
    permission = .*/hyprpicker, screencopy, allow
  '';
}

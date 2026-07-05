{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
    "TMUX_TMPDIR,/run/user/1000"
      "XCURSOR_SIZE,12"
      "HYPRCURSOR_SIZE,12"
      "GTK_THEME,Adwaita:dark"
    "PATH,${config.home.profileDirectory}/bin:$PATH"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    ecosystem {
      enforce_permissions = 1
    }

    permission = .*/grim, screencopy, allow
    permission = .*/\.xdg-desktop-portal-hyprland, screencopy, allow
    permission = .*/\.xdg-desktop-portal-hyprland-wrapped, screencopy, allow
    permission = .*/hyprpm, plugin, allow
    permission = .*/hyprshot, screencopy, allow
    permission = .*/hypridle, screencopy, allow
    permission = .*/hyprlock, screencopy, allow
    permission = .*/hyprpicker, screencopy, allow
  '';
}

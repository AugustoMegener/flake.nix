{ ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
  '';
}

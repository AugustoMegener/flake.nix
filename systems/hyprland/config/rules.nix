{ ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    windowrule {
      name = obsidian-borderles
      match:class = electron
      border_color = rgba(0)
      border_size = 0
    }
    windowrule {
      name = obsidian-workspace
      match:class = obsidian
      workspace = 1 silent
    }
    windowrule {
      name = termfilechooser-float
      match:title = termfilechooser
      float = true
      size = 800 600
      center = true
    }

    layerrule = no_anim on, match:namespace quickshell
  '';
}

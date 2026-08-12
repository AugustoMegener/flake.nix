{ ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    hl.config({
      input = {
        kb_layout = "br",
        kb_variant = "abnt2",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
          natural_scroll = false,
        },
      },
    })

    hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })
    hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
  '';
}

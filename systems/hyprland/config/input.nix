{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "br";
      kb_variant = "abnt2";
      kb_model = "";
      kb_options = "";
      kb_rules = "";
      follow_mouse = 1;
      sensitivity = 0;

      touchpad = {
        natural_scroll = false;
      };
    };

    device = {
      name = "epic-mouse-v1";
      sensitivity = -0.5;
    };
  };

  wayland.windowManager.hyprland.extraConfig = ''
    gesture = 3, horizontal, workspace
  '';
}

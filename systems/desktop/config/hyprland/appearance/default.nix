{ ... }:
{
  wayland.windowManager.hyprland.extraLuaFiles."appearance" = {
    content = ./appearance.lua;
    autoLoad = true;
  };
}

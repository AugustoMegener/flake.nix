{ ... }:
{
  wayland.windowManager.hyprland = {
    extraLuaFiles."keybinds" = {
      content = ./config.lua;
      autoLoad = true;
    };
  };
}

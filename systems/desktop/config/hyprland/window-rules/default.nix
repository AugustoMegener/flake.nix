{ ... }:
{
  wayland.windowManager.hyprland = {
    configType = "lua";
    extraLuaFiles."windowrules" = {
      content = ./config.lua;
      autoLoad = true;
    };
  };
}

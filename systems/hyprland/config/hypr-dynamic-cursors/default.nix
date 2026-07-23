{ pkgs, ... }:
{
    wayland.windowManager.hyprland = {
      plugins = [ pkgs.hyprlandPlugins.hypr-dynamic-cursors ];

      extraLuaFiles."plugins.dynamic-cursors" = {
        autoLoad = true;
        text = ./config.lua;
      };
    };
}

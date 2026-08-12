{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    plugins = [ pkgs.hyprlandPlugins.hypr-dynamic-cursors ];

    extraConfig = ''
      hl.permission(".*hypr-dynamic-cursors.*", "plugin", "allow")
    '';

    extraLuaFiles."plugins.dynamic-cursors" = {
      autoLoad = true;
      content = ./config.lua;
    };
  };
}

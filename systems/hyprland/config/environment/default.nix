{ config, ... }:
{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      hl.env("TMUX_TMPDIR", "/run/user/1000")
      hl.env("XCURSOR_SIZE", "28")
      hl.env("GTK_THEME", "Adwaita:dark")
      hl.env("HYPRCURSOR_THEME", "kny-hyprcursor")
      hl.env("HYPRCURSOR_SIZE", "28")
      hl.env("PATH", "${config.home.profileDirectory}/bin:" .. (os.getenv("PATH") or ""))
    '';

    extraLuaFiles."environment" = {
      content = ./config.lua;
      autoLoad = true;
    };
  };
}

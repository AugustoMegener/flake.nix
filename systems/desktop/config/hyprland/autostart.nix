{ ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
      hl.exec_cmd("bolcshell --daemonize")
      hl.exec_cmd("swaync")
      hl.exec_cmd("obsidian")
      hl.exec_cmd("sleep 5; systemd-run --user --scope --slice=app elephant")
      hl.exec_cmd("walker --gapplication-service")
    end)
  '';
}

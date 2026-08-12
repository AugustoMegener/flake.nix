hl.config({
  ecosystem = {
    enforce_permissions = true
  }
})

hl.permission({ binary = ".*/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = ".*/\\.xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = ".*/\\.xdg-desktop-portal-hyprland-wrapped", type = "screencopy", mode = "allow" })

hl.permission({ binary = ".*/hyprpm", type = "plugin", mode = "allow" })
hl.permission({ binary = ".*/hyprctl", type = "plugin", mode = "allow" })

hl.permission({ binary = ".*/hyprshot", type = "screencopy", mode = "allow" })
hl.permission({ binary = ".*/hypridle", type = "screencopy", mode = "allow" })
hl.permission({ binary = ".*/hyprlock", type = "screencopy", mode = "allow" })
hl.permission({ binary = ".*/hyprpicker", type = "screencopy", mode = "allow" })

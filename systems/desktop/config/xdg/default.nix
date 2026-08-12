{ pkgs, ... }:
let
  yazi-wrapper = pkgs.writeShellScript "yazi-wrapper.sh" ''
    kitty -- yazi "$@"
  '';

  termfilechooser-config = (pkgs.formats.toml {}).generate "config" {
    filechooser = {
      cmd = "yazi-wrapper.sh";
      env = "TERMCMD=kitty --title termfilechooser";
      default_dir = "$HOME";
    };
  };

  xdg-portal-termfilechooser = pkgs.stdenv.mkDerivation rec {
    pname = "xdg-desktop-portal-termfilechooser";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "hunkyburrito";
      repo = "xdg-desktop-portal-termfilechooser";
      rev = "main";
      sha256 = "sha256-zk/zUbq+fa977wuT/yuJ+bBawuTXKVJwLj2G8ITjMfU=";
    };
    nativeBuildInputs = [ pkgs.meson pkgs.ninja pkgs.pkg-config pkgs.scdoc ];
    buildInputs = [ pkgs.glib pkgs.dbus pkgs.xdg-desktop-portal pkgs.cmake pkgs.inih pkgs.json-glib pkgs.systemd ];
    mesonFlags = [ "-Dsd-bus-provider=libsystemd" ];
    postInstall = ''
      cp ${termfilechooser-config} $out/share/xdg-desktop-portal-termfilechooser/config
    '';
  };
  
xdg.terminal-exec = {
  enable = true;
  package = pkgs.kitty; # ou o pacote do seu terminal
};

  yazi-kitty = pkgs.stdenv.mkDerivation {
    pname = "yazi-kitty";
    version = "1.0";
    dontUnpack = true;
    buildCommand = ''
      mkdir -p $out/bin
      cat > $out/bin/yazi-kitty.sh << 'SCRIPT'
      #!/bin/sh
      exec kitty -- dir-open "$@"
      SCRIPT
      chmod +x $out/bin/yazi-kitty.sh
    '';
  };
in
{
  home.packages = [ yazi-kitty ];

  xdg.desktopEntries.yazi-kitty = {
    name = "Yazi";
    type = "Application";
    exec = "dir-open %f";
    terminal = false;
    noDisplay = true;
    mimeType = [ "inode/directory" ];
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser" = {
    source = "${xdg-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser";
    recursive = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk xdg-portal-termfilechooser ];
    config.common.default = [ "hyprland" "termfilechooser" ];
  };
  
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];

      "image/bmp" = [ "org.kde.krita.desktop" ];
      "image/gif" = [ "org.kde.krita.desktop" ];
      "image/jpeg" = [ "org.kde.krita.desktop" ];
      "image/png" = [ "org.kde.krita.desktop" ];
      "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
      "image/tiff" = [ "org.kde.krita.desktop" ];
      "image/webp" = [ "org.kde.krita.desktop" ];
      "image/x-xcf" = [ "org.kde.krita.desktop" ];

      "inode/directory" = [ "yazi-kitty.desktop" ];

      "text/html" = [ "zen-browser.desktop" ];
      "text/plain" = [ "nvim.desktop" ];

      "x-scheme-handler/about" = [ "zen-browser.desktop" ];
      "x-scheme-handler/http" = [ "zen-browser.desktop" ];
      "x-scheme-handler/https" = [ "zen-browser.desktop" ];
      "x-scheme-handler/unknown" = [ "zen-browser.desktop" ];

      # LibreOffice Writer
      "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
      "application/msword" = [ "writer.desktop" ];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
      "application/rtf" = [ "writer.desktop" ];

      # LibreOffice Calc
      "application/vnd.oasis.opendocument.spreadsheet" = [ "calc.desktop" ];
      "application/vnd.ms-excel" = [ "calc.desktop" ];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "calc.desktop" ];

      # LibreOffice Impress
      "application/vnd.oasis.opendocument.presentation" = [ "impress.desktop" ];
      "application/vnd.ms-powerpoint" = [ "impress.desktop" ];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "impress.desktop" ];

      # LibreOffice Draw
      "application/vnd.oasis.opendocument.graphics" = [ "draw.desktop" ];

      # LibreOffice Math
      "application/vnd.oasis.opendocument.formula" = [ "math.desktop" ];
    };
  };

  xdg.userDirs = {
    enable = true;
    setSessionVariables = false;
  };
}

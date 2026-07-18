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

  yazi-kitty = pkgs.stdenv.mkDerivation {
    pname = "yazi-kitty";
    version = "1.0";
    dontUnpack = true;
    buildCommand = ''
      mkdir -p $out/bin
      cat > $out/bin/yazi-kitty.sh << 'SCRIPT'
      #!/bin/sh
      exec kitty -- yazi "$@"
      SCRIPT
      chmod +x $out/bin/yazi-kitty.sh

      mkdir -p $out/share/applications
      cat > $out/share/applications/yazi-kitty.desktop << 'DESKTOP'
      [Desktop Entry]
      Type=Application
      Name=Yazi (Kitty)
      Exec=yazi-kitty.sh %f
      Terminal=false
      MimeType=inode/directory;
      NoDisplay=true
      DESKTOP
    '';
  };
in
{
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
      "text/html" = ["zen-browser.desktop"];
      "x-scheme-handler/http" = ["zen-browser.desktop"];
      "x-scheme-handler/https" = ["zen-browser.desktop"];
      "x-scheme-handler/about" = ["zen-browser.desktop"];
      "x-scheme-handler/unknown" = ["zen-browser.desktop"];
      #"inode/directory" = [ "yazi-kitty.desktop" ];
      "text/plain" = [ "nvim.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
    };
  };
  xdg.userDirs = {
    enable = true;
    setSessionVariables = false;

    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    videos = "$HOME/Videos";
  };
  home.packages = [ yazi-kitty ];
xdg.desktopEntries.walker-dir-open = {
  name = "Walker Dir Open";
  exec = "walker-dir-open %f";
  terminal = false;
  noDisplay = true;
  mimeType = [ "inode/directory" ];
};

xdg.mimeApps.defaultApplications."inode/directory" = "walker-dir-open.desktop";
}

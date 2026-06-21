{ config, pkgs, ... }:

let
  flashpoint = pkgs.stdenv.mkDerivation {
    pname = "flashpoint";
    version = "1.0";

    dontUnpack = true;

    fhs = pkgs.buildFHSEnv {
      name = "flashpoint-fhs";
      targetPkgs = pkgs: with pkgs; [
        toybox
        electron
        pipewire pulseaudio
        gtk3 gtk2 nss php wine
        xorg.libX11 xorg.libXt xorg.libXcomposite
        mesa
        glib nspr at-spi2-atk cups dbus libdrm pango cairo expat libxkbcommon alsa-lib
        xorg.libXdamage xorg.libXext xorg.libXfixes xorg.libXrandr xorg.libxcb
        udev
      ];
    };

    installPhase = ''
      mkdir -p $out/bin
      ln -s ${fhs}/bin/flashpoint-fhs $out/bin/flashpoint

      mkdir -p $out/share/applications
      cat > $out/share/applications/flashpoint.desktop <<EOF
[Desktop Entry]
Name=Flashpoint
Exec=flashpoint
Icon=flashpoint
Type=Application
Categories=Game;
EOF
    '';
  };
in {
  home.packages = [
    flashpoint
  ];
}

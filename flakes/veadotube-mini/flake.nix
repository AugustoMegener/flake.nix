{
  description = "Veadotube Mini";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    desktopItem = pkgs.makeDesktopItem {
      name = "veadotube-mini";
      desktopName = "Veadotube Mini";
      comment = "Avatar app for VTubing";
      exec = "veadotube-mini";
      icon = "veadotube-mini";
      categories = [ "AudioVideo" "Graphics" ];
      terminal = false;
    };
  in {
    packages.${system}.default = pkgs.stdenvNoCC.mkDerivation {
      pname = "veadotube-mini";
      version = "1.0";
      src = pkgs.fetchurl {
        url = "https://github.com/AugustoMegener/flake.nix/releases/download/flake-input/veadotube-mini-linux-x64.zip";
        sha256 = "sha256:247802f6784c4ebefacdabe68fc93399d4f23b0585752275944a71dbac809eb0";
      };

      iconFile = ./icon.png;

      nativeBuildInputs = [
        pkgs.unzip
        pkgs.makeWrapper
        pkgs.autoPatchelfHook
      ];
      buildInputs = [
        pkgs.stdenv.cc.cc.lib
        pkgs.glib
        pkgs.zlib
        pkgs.icu
        pkgs.fontconfig
        pkgs.freetype
        pkgs.libGL
        pkgs.libGLU
        pkgs.libglvnd
        pkgs.libglvnd.dev
        pkgs.mesa
        pkgs.libgbm
        pkgs.vulkan-loader
        pkgs.libdrm
        pkgs.libxkbcommon
        pkgs.fribidi
        pkgs.libXScrnSaver
        pkgs.wayland
        pkgs.wayland-protocols
        pkgs.libdecor
        pkgs.pipewire
        pkgs.pulseaudio
        pkgs.alsa-lib
        pkgs.jack2
        pkgs.libusb1
        pkgs.sndio
        pkgs.liburing
        pkgs.xorg.libX11
        pkgs.xorg.libXcursor
        pkgs.xorg.libXi
        pkgs.xorg.libXrandr
        pkgs.xorg.libXtst
      ];

      autoPatchelfIgnoreMissingDeps = [
        "libsteam_api.so"
        "libGLES_CM.so.1"
      ];

      unpackPhase = ''
        unzip "$src"
      '';
      installPhase = ''
        mkdir -p $out
        cp -r ./* $out/
        chmod -R u+w $out
        chmod +x $out/veadotube-mini
        mkdir -p $out/bin
        makeWrapper $out/veadotube-mini $out/bin/veadotube-mini \
          --chdir $out \
          --prefix LD_LIBRARY_PATH : "${pkgs.icu}/lib:${pkgs.fontconfig.lib}/lib:${pkgs.freetype}/lib" \
          --prefix PATH : "${pkgs.file}/bin" \
          --set FONTCONFIG_FILE "${pkgs.fontconfig.out}/etc/fonts/fonts.conf"

        mkdir -p $out/share/applications
        ln -s ${desktopItem}/share/applications/*.desktop $out/share/applications/

        mkdir -p $out/share/icons/hicolor/256x256/apps
        cp ${iconFile} $out/share/icons/hicolor/256x256/apps/veadotube-mini.png
      '';
    };
  };
}

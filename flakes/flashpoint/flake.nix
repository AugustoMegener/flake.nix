{
  description = "Flashpoint Archive 14.0.3 - Linux native";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    flashpointData = pkgs.stdenv.mkDerivation {
      name = "flashpoint-data-14.0.3";
      src = pkgs.fetchurl {
        url = "https://download.unstable.life/upload/fp14.0.3_lin_20251201.7z";
        sha256 = "f393a98c5c35e229a744c102b0cb53270b1b4f1b3ebd40d604f98323444a4b1f";
      };
      nativeBuildInputs = [ pkgs._7zz ];
      unpackPhase = "7zz x $src -oflashpoint";
      installPhase = ''
        cp -r flashpoint $out
        find $out -name "*.sh" -exec chmod +x {} \;
        cp ${pkgs.mesa.drivers}/lib/dri/swrast_dri.so \
          $out/Libraries/lib/x86_64-linux-gnu/dri/swrast_dri.so
      '';
      dontBuild = true;
      dontFixup = true;
    };

    flashpoint = pkgs.buildFHSEnv {
      name = "flashpoint";
      targetPkgs = p: with p; [
        file
        php
        xkeyboard_config
        xdg-utils
        bash
        wine
        mesa
        mesa.drivers
        libglvnd
        libGL
        libGLU
        libx11
        libxt
        libxcomposite
        glib
        nspr
        libdrm
        pango
        cairo
        expat
        libxkbcommon
        alsa-lib
        libxdamage
        libxext
        libxfixes
        libxrandr
        libxcb
        udev
        pipewire
        pulseaudio
      ];
      runScript = pkgs.writeShellScript "flashpoint-run" ''
cat > ~/.local/share/applications/flashpoint-archive.desktop << EOF
[Desktop Entry]
Type=Application
Name=Flashpoint Archive
Comment=An archive for games and animations from the web.
Icon=$HOME/.local/share/flashpoint/Launcher/icon.svg
StartupWMClass=flashpoint-launcher
Exec=flashpoint
Path=$HOME
Terminal=false
Categories=Archiving;Game;
SingleMainWindow=true
EOF
        FP_DIR="''${FLASHPOINT_DIR:-$HOME/.local/share/flashpoint}"
        if [ ! -f "$FP_DIR/start-flashpoint.sh" ]; then
          echo "Inicializando Flashpoint em $FP_DIR ..."
          mkdir -p "$FP_DIR"
          cp -r ${flashpointData}/. "$FP_DIR"
          chmod -R u+w "$FP_DIR"
          echo "Pronto."
        fi
        export DISPLAY=localhost:0
        export BROWSER=false
        export LIBGL_ALWAYS_SOFTWARE=1
        export GALLIUM_DRIVER=llvmpipe
        cd "$FP_DIR"
        exec ./start-flashpoint.sh
      '';
    };
  in
  {
    packages.${system} = {
      default    = flashpoint;
      flashpoint = flashpoint;
    };
    apps.${system}.default = {
      type    = "app";
      program = "${flashpoint}/bin/flashpoint";
    };
    nixosModules.default = { ... }: {
      environment.systemPackages = [ flashpoint ];
    };
  };
}

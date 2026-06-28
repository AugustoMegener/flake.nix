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
      '';
      dontBuild = true;
      dontFixup = true;
    };

    flashpoint = pkgs.buildFHSEnv {
      name = "flashpoint";
extraBwrapArgs = [
  "--ro-bind" "/tmp/.X11-unix/X0" "/tmp/.X11-unix/X0"
];
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
  export LIBGL_DRIVERS_PATH="${pkgs.mesa.drivers}/lib/dri"
  export LIBGL_ALWAYS_SOFTWARE=1
  export GALLIUM_DRIVER=llvmpipe
  cd "$FP_DIR"
  [ `id -u` -ne 0 ] && cd -P -- "$FP_DIR" || exit 1
  if [ "`file -b --mime-type Libraries/lib/x86_64-linux-gnu/libgtk-3.so.0`" = 'application/x-sharedlib' ]; then
    export GDK_PIXBUF_MODULE_FILE="$FP_DIR/Libraries/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    export GSETTINGS_SCHEMA_DIR="$FP_DIR/Libraries/share/glib-2.0/schemas"
    export GTK_MODULES=
    export LD_LIBRARY_PATH="$FP_DIR/Libraries/lib/x86_64-linux-gnu"
    export PATH="$FP_DIR/Libraries/bin"
  fi
  export WINEPREFIX="$FP_DIR/FPSoftware/Wine"
  cd "$FP_DIR/Launcher"
  exec ./flashpoint-launcher --js-flags=--lite_mode --ozone-platform-hint=auto
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

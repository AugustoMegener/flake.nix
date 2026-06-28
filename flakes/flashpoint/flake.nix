{
  description = "Flashpoint Archive 14.0.3 - Linux native";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

      pname = "flashpoint-data";
      flashpointData = pkgs.stdenv.mkDerivation {
      version = "14.0.3";

      src = pkgs.fetchurl {
        url = "https://download.unstable.life/upload/fp14.0.3_lin_20251201.7z";
        sha256 = "f393a98c5c35e229a744c102b0cb53270b1b4f1b3ebd40d604f98323444a4b1f";
      };

      nativeBuildInputs = [ pkgs.p7zip ];

      unpackPhase = ''
        7z x $src -oflashpoint
      '';

      installPhase = ''
        cp -r flashpoint $out
        find $out -name "*.sh" -exec chmod +x {} \;
      '';

      dontBuild = true;
      dontFixup = true;
    };

    flashpoint = pkgs.buildFHSEnv {
      name = "flashpoint";

targetPkgs = p: with p; [
  toybox
  file
  electron
  pipewire
  pulseaudio
  gtk3
  gtk2
  nss
  php
  wine
  libx11
  libxt
  libxcomposite
  mesa
  libGL
  libGLU
  glib
  nspr
  at-spi2-atk
  cups
  # dbus   <- remove
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

        cd "$FP_DIR"
        exec ./start-flashpoint.sh --no-sandbox "$@"
      '';
    };
  in
  {
    packages.${system} = {
      default   = flashpoint;
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

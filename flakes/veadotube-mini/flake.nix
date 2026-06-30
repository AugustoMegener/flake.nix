{
  description = "Veadotube Mini";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.stdenvNoCC.mkDerivation {
      pname = "veadotube-mini";
      version = "1.0";
      src = pkgs.fetchurl {
        url = "https://github.com/AugustoMegener/flake.nix/releases/download/flake-input/veadotube-mini-linux-x64.zip";
        sha256 = "sha256:247802f6784c4ebefacdabe68fc93399d4f23b0585752275944a71dbac809eb0";
      };
      nativeBuildInputs = [
        pkgs.unzip
        pkgs.makeWrapper
        pkgs.autoPatchelfHook
      ];
      buildInputs = [
        pkgs.stdenv.cc.cc.lib
        pkgs.glib
        pkgs.zlib
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

      dontAutoPatchelf = true;

      unpackPhase = ''
        unzip "$src"
      '';
      installPhase = ''
        mkdir -p $out
        cp -r ./* $out/
        chmod +x $out/veadotube-mini
        mkdir -p $out/bin
        makeWrapper $out/veadotube-mini $out/bin/veadotube-mini \
          --chdir $out
      '';

      postFixup = ''
        addAutoPatchelfSearchPath $out/lib
        autoPatchelf --ignore-missing libsteam_api.so --ignore-missing libGLES_CM.so.1 $out
      '';
    };
  };
}

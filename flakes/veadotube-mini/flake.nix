{
  description = "veadotube-mini";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "veadotube-mini";
      version = "1.0";

      src = ./veadotube-mini-linux-x64.zip;

      nativeBuildInputs = with pkgs; [
        unzip
        autoPatchelfHook
      ];

      buildInputs = with pkgs; [
        mesa
        mesa.drivers
        libGL
        libglvnd
        libgbm
        libdrm
        libxkbcommon
        wayland
        libpulseaudio
        alsa-lib
        pipewire
        jack2
        libusb1
        fribidi
        dbus
        systemd
      ];

      autoPatchelfIgnoreMissing = [
        "libsteam_api.so"
        "libGLES_CM.so.1"
      ];

      installPhase = ''
        mkdir -p $out
        cp -r ./* $out/
      '';
    };
  };
}

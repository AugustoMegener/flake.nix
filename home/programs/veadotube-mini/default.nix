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

      src = ./veadotube-mini-linux-x64.zip;

      nativeBuildInputs = [
        pkgs.unzip
        pkgs.makeWrapper
      ];

      unpackPhase = ''
        unzip "$src"
      '';

      installPhase = ''
        mkdir -p $out

        cp -r ./* $out/

        chmod +x $out/veadotube-mini

        mkdir -p $out/bin

        makeWrapper $out/veadotube-mini $out/bin/veadotube-mini \
          --chdir $out \
          --prefix LD_LIBRARY_PATH : $out/lib
      '';
    };
  };
}

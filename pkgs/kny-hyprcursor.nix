{ stdenvNoCC, fetchFromGitHub, hyprcursor }:

stdenvNoCC.mkDerivation {
  pname = "kny-hyprcursor";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "AugustoMegener";
    repo = "kny-hyprcursor";
    rev = "main";
    hash = "sha256-q5AXpka4PQUZY+MoDJGdxzMxvAdjgZp/FEbP+qUVYqA=";
  };

  nativeBuildInputs = [ hyprcursor ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/icons
    hyprcursor-util -c $src -o $out/share/icons

    shopt -s nullglob
    themeDirs=("$out"/share/icons/theme_*)
    mv "''${themeDirs[0]}" "$out/share/icons/kny-hyprcursor"
  '';
}

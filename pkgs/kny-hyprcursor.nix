{ stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "kny-hyprcursor";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "AugustoMegener";
    repo = "kny-hyprcursor";
    rev = "main";
    hash = "sha256-NogT56G151NwLt3sYxUFBbZej5/hwl7V99+HMU42EAA=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/icons/kny-hyprcursor
    cp -r $src/* $out/share/icons/kny-hyprcursor/
  '';
}

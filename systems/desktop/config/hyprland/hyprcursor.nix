{ pkgs, ... }:
let 
  kny-hyprcursor = pkgs.stdenvNoCC.mkDerivation {
    pname = "kny-hyprcursor";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "AugustoMegener";
      repo = "kny-hyprcursor";
      rev = "main";
      hash = "sha256-q5AXpka4PQUZY+MoDJGdxzMxvAdjgZp/FEbP+qUVYqA=";
    };

    nativeBuildInputs = [ pkgs.hyprcursor ];

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/icons
      hyprcursor-util -c $src -o $out/share/icons

      shopt -s nullglob
      themeDirs=("$out"/share/icons/theme_*)
      mv "''${themeDirs[0]}" "$out/share/icons/kny-hyprcursor"
    '';
  };
in
{
  home.packages = with pkgs; [ hyprcursor ];

  home.pointerCursor = {
    enable = true;
    package = kny-hyprcursor;
    name = "kny-hyprcursor";
    size = 30;

    hyprcursor.enable = true;
  };
}

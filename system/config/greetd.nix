{ ... }:
{

  programs.regreet = {
    enable = false;

    cageArgs = [ "-s" ];
    extraCss = builtins.readFile ./greetd.css;
  };
}

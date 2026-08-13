{ ... }:
{

  programs.regreet = {
    enable = true;

    cageArgs = [ "-s" ];
    extraCss = builtins.readFile ./greetd.css;
  };
}

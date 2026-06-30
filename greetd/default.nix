{ pkgs, ... }:
{

  programs.regreet = {
    enable = true;

    cageArgs = [ "-s" ];
    extraCss = builtins.readFile ./style.css;
  };
}

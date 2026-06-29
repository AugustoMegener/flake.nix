{ pkgs, ... }:
{

  services.greetd = {
    enable = true;
    cageArgs = [ "-s" ];
    settings = {
      default_session = {
        command = "${pkgs.greetd.regreet}/bin/regreet";
        user = "kito";
      };
    };
  };


  programs.regreet = {
    enable = true;
    extraCss = builtins.readFile ./style.css;
  };
}

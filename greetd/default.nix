{ pkgs, ... }:
{

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.greetd.regreet}/bin/regreet";
        user = "kito";
      };
    };
  };


  programs.regreet = {
    enable = true;

    cageArgs = [ "-s" ];
    extraCss = builtins.readFile ./style.css;
  };
}

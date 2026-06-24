{ ... }:
{
  programs.walker = {
    enable = true;
    themes = {
      screenshot = {
        style = "";
        config.columns."dmenu" = 3;
      };
    };
  };
}

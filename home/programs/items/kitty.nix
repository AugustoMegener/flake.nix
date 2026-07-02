{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      background            = "#302b24";
      foreground            = "#d5bea1";
      font_family           = "GoMono Nerd Font";
      window_padding_width  = 5;
      confirm_os_window_close = 0;

      color0  = "#2b2622"; # black
      color1  = "#f25146"; # red
      color2  = "#108454"; # green
      color3  = "#da9a22"; # yellow
      color4  = "#4396b7"; # blue
      color5  = "#6260c1"; # magenta
      color6  = "#23a89d"; # cyan
      color7  = "#d5bea1"; # white

      color8  = "#46392d"; # bright black
      color9  = "#FB8479"; # bright red
      color10 = "#4dc58d"; # bright green
      color11 = "#E2BD60"; # bright yellow
      color12 = "#6ABFD2"; # bright blue
      color13 = "#8A87D9"; # bright magenta
      color14 = "#60d1c7"; # bright cyan
      color15 = "#ebd9c6"; # bright white
    };
  };
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    elephant walker
  ];
/*xdg.configFile."walker/themes/screenshot/style.css".text = "";
xdg.configFile."walker/themes/screenshot/config.toml".text = ''
  [columns]
  "dmenu" = 3
'';*/
}

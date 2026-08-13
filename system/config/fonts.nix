{ pkgs, ... }: 
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.go-mono
      (google-fonts.override { fonts = [ "Bricolage Grotesque" "Domine" ]; })
      twemoji-color-font
    ];

    fontconfig.defaultFonts = {
      serif = [ "Domine" ];
      sansSerif = [ "Domine" ];
      monospace = [ "GoMono Nerd Font" ];
    };
  };
}

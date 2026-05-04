{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/home/kito/Pictures/Backgrounds/main-bg.png" ];
      wallpaper = [
        {
          monitor = "VGA-1";
          path = "/home/kito/Pictures/Backgrounds/main-bg.png";
        }
      ];
      splash = false;
    };
  };
}

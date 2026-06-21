{ ... }:
{
  services.hyprpaper = {
    enable = false;
    settings = {
      preload = [ "/home/kito/Pictures/Backgrounds/bg-1.jpg" ];
      wallpaper = [
        {
          monitor = "VGA-1";
          path = "/home/kito/Pictures/Backgrounds/bg-1.jpg";
        }
      ];
      splash = false;
    };
  };
}

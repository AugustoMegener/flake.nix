{ ... }:
{
programs.hyprlock = {
  enable = true;
  settings = {
    general = {
      disable_loading_bar = false;
      hide_cursor = true;
    };

    background = [
      {
        path = "/home/kito/Pictures/Backgrounds/bg-1.jpg";
        blur_passes = 2;
        blur_size = 7;
      }
    ];

    input-field = [
      {
        size = "300, 50";
        position = "0, -100";
        halign = "center";
        valign = "center";
        outline_thickness = 2;
        inner_color = "rgb(48, 43, 36)";
        outer_color = "rgb(43, 38, 34)";
        font_color = "rgb(170, 144, 109)";
        placeholder_text = "senha...";
        check_color = "rgb(100, 200, 100)";
        fail_color = "rgb(242, 81, 70)";
      }
    ];

    label = [
      {
        text = "$TIME";
        font_size = 64;
        position = "0, 100";
        halign = "center";
        valign = "center";
        color = "rgb(170, 144, 109)";
      }
    ];
  };
};
}

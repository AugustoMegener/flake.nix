{ ... }:
{
  hardware = {
    graphics.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.FastConnectable = true;
    };
  };
}

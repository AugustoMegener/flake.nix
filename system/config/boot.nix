{ pkgs, lib, ... }:
{

  boot = {
    kernelModules = [ "btusb" ];
    kernelParams = [ 
      "quiet" 
      "splash"
      "acpi_backlight=native"
    ];
    kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
      lib.mkDefault pkgs.linuxPackages_6_18
    );
    plymouth.enable = true;
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}

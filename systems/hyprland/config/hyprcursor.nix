{ pkgs, ... }:
{
  home.packages = with pkgs; [ hyprcursor ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.callPackage ../../../pkgs/kny-hyprcursor.nix { };
    name = "kny-hyprcursor";
    size = 30;

    hyprcursor.enable = true;
  };
}

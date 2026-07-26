{ pkgs, ... }:
{
  home.packages = with pkgs; [ discord betterdiscord-installer betterdiscordctl ];
}

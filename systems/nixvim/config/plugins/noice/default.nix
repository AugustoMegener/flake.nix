{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    noice-nvim
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}

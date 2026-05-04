{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-surround
    indent-blankline-nvim
    nvim-colorizer-lua
    auto-save-nvim
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}

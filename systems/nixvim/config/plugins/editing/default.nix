{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-surround
    indent-blankline-nvim
    nvim-colorizer-lua
  ];

  plugins.auto-session = {
    enable = true;
  };

  extraConfigLua = builtins.readFile ./setup.lua;
}

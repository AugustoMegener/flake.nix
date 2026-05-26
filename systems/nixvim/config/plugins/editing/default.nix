{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-surround
    indent-blankline-nvim
    nvim-colorizer-lua
  ];

  plugins.auto-session = {
    enable = false;
    settings.pre_save_cmds = [ "lua pcall(MiniFiles.close)" ];
  };

  extraConfigLua = builtins.readFile ./setup.lua;
}

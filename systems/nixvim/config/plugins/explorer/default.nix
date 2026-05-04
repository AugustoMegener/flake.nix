{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    telescope-nvim
    neo-tree-nvim
  ];

  extraPackages = with pkgs; [
    fd
    ripgrep
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}

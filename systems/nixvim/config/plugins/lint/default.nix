{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-lint
  ];

  extraPackages = with pkgs; [
    ktlint
  ];

  extraConfigLua = builtins.readFile ./setup.lua;
}

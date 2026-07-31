{ pkgs, ... }:
let
  rebuild-system = pkgs.writeShellScriptBin "rebuild-system" (builtins.readFile ./rebuild-system.sh);
  hyprdispatch = pkgs.writeShellScriptBin "hyprdispatch" (builtins.readFile ./hyprdispatch.sh);
  hyprfloat-kitty = pkgs.writeShellScriptBin "hyprfloat-kitty" (builtins.readFile ./hyprfloat-kitty.sh);
  tmux-next-session = pkgs.writeShellScriptBin "tmux-next-session" (builtins.readFile ./tmux-next-session.sh);
  launcher-wrapper = pkgs.writeShellScriptBin "launcher-wrapper" (builtins.readFile ./launcher-wrapper.sh);
  init-tmux = pkgs.writeShellScriptBin "init-tmux" (builtins.readFile ./init-tmux.sh);
  init-yazi = pkgs.writeShellScriptBin "init-yazi" (builtins.readFile ./init-yazi.sh);
  tmux-session-finder = pkgs.writeShellScriptBin "tmux-session-finder" (builtins.readFile ./tmux-session-finder.sh);
  yazi-edit = pkgs.writeShellScriptBin "yazi-edit" (builtins.readFile ./yazi-edit.sh);
  dir-open = pkgs.writeShellScriptBin "dir-open" (builtins.readFile ./dir-open.sh);
in
{
  home.packages = [
    rebuild-system
    hyprdispatch
    hyprfloat-kitty
    tmux-next-session
    launcher-wrapper
    init-tmux
    init-yazi
    tmux-session-finder
    yazi-edit
    dir-open
  ];
}

{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    discord
    betterdiscord-installer
    betterdiscordctl
    sway
    hyprpolkitagent
    superfile
    hyprpicker
    krita
    zathura
    cliphist
    hyprshot
    wl-clipboard
    prismlauncher
    inputs.ags.packages.${pkgs.system}.agsFull
    inkscape
    inputs.zen-browser.packages.x86_64-linux.default
    inputs.hytale-launcher.packages.x86_64-linux.default
  ];
}

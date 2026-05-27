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
    inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.agsFull
    inkscape
    /*inputs.hytale-launcher.packages.x86_64-linux.default*/
  ];
}

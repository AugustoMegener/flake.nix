{ config, pkgs, inputs, lib, ... }: {
  home.packages = [
    inputs.zen-browser.packages.x86_64-linux.default
  ];

  home.activation.firenvimInstall = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/.mozilla/native-messaging-hosts"
    nvim --headless -c "call firenvim#install(1)" -c quit 2>/dev/null || true
  '';
}

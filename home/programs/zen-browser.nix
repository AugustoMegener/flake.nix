{ config, pkgs, inputs, ... }:
let
  firenvimScript = pkgs.writeShellScript "firenvim" ''
    exec nvim --headless --cmd "let g:started_by_firenvim = v:true" -c "call firenvim#run()"
  '';
in {
  home.packages = [
    inputs.zen-browser.packages.x86_64-linux.default
  ];

  home.file.".local/share/firenvim/firenvim".source = firenvimScript;

  home.file.".zen/native-messaging-hosts/firenvim.json".text = builtins.toJSON {
    name = "firenvim";
    description = "Turn your browser into a Neovim client.";
    path = "${config.home.homeDirectory}/.local/share/firenvim/firenvim";
    type = "stdio";
    allowed_extensions = [ "firenvim@lacambre.fr" ];
  };
}

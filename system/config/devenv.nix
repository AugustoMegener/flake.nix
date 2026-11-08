{ pkgs, lib, config, ... }:
{ 
  /*environment.systemPackages = [
    pkgs.devenv
  ];
  scripts.caddy-setcap.exec = lib.mkForce ''
    mkdir -p ./bin
    cp ${pkgs.caddy}/bin/caddy ./bin/caddy
    sudo setcap 'cap_net_bind_service=+ep' ./bin/caddy
  '';

  processes.caddy-local.exec = ''${lib.replaceString "${pkgs.caddy}" "." config.processes.caddy.exec}'';*/
}

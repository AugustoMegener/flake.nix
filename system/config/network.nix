{ ... }:
{ 
    networking.networkmanager.enable = true;

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 59100 22 ];
      allowedUDPPorts = [ 59100 59200 ];
    };
}

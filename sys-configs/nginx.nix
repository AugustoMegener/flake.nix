{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;

    package = pkgs.nginx.override {
      modules = with pkgs.nginxModules; [ rtmp ];
    };

    appendConfig = ''
      rtmp {
        server {
          listen 1935;
          application live {
            live on;
            push rtmp://a.rtmp.youtube.com/live2/${config.sops.secrets.youtube-stream-key.path or "STREAM_KEY"};
            push rtmp://live.tiktok.com/live/${config.sops.secrets.tiktok-stream-key.path or "STREAM_KEY"};
          }
        }
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 1935 ];
}

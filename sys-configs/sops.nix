{ sops, ... }:
{
  sops.defaultSopsFile = ../.secrets/secrets.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";  

  sops.secrets.youtube-stream-key = {};
  sops.secrets.tiktok-stream-key = {};
}

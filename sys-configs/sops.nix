{ ... }:
{
  sops.defaultSopsFile = ../secrets/secrets.yaml;
sops.age.keyFile = "/home/kito/.config/sops/age/keys.txt";

sops.secrets."neomd/user" = {};
sops.secrets."neomd/password" = {};
sops.secrets."neomd/from" = {};
}

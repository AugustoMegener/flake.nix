{ ... }:
{
  imports =
    map
      (fn: ./config/${fn})
      (builtins.filter (fn: builtins.match ".*\\.nix" fn != null)
        (builtins.attrNames (builtins.readDir ./config)));


  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "pt_BR.UTF-8";

  console.keyMap = "br-abnt2";
 
  
  security.polkit.enable = true;

  home-manager.backupFileExtension = "bak";

  nix = {

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}

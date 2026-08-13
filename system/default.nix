{ pkgs, ... }:
{
  imports =
    map
      (fn: ./config/${fn})
      (builtins.filter (fn: builtins.match ".*\\.nix" fn != null)
        (builtins.attrNames (builtins.readDir ./config)));

  networking.hostName = "Sputnik-I"; 

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "pt_BR.UTF-8";

  console.keyMap = "br-abnt2";
 

  users =  {
    users.kito = {
      isNormalUser = true;
      shell = pkgs.zsh;

      extraGroups = [
        "input"
        "video"
        "audio"
        "networkmanager"
        "wheel"
      ];

      packages = with pkgs; [
        efibootmgr
        tree
      ];
    };

    defaultUserShell = pkgs.zsh;
  };
  
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

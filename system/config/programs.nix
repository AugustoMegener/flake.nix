{ ... }:
{
  programs = {
    zsh.enable = true;
    hyprland.enable = true;

    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings."org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        }
      ];
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;  
      dedicatedServer.openFirewall = true; 
      
      gamescopeSession.enable = true;
    };

    fuse.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    mtr.enable = true;

  };
}

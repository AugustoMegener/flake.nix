{ ...}: 
{
  programs.tmux = {

    extraConfig = ''
      set -g status-style "bg=default,fg=#9c7d5e"

      set -g status-position top
      set -g status-justify left

      set -g window-status-format "#[fg=#9c7d5e,bg=#2e261f] #I #W "
      set -g window-status-current-format "#[fg=#342c23,bg=#2e261f]#[bg=#342c23,fg=#d7c0a3,bold]#I#[bg=#f25146,fg=#342c23,bold]#[fg=#2e261f,bg=#f25146] #W#[fg=#f25146,bg=#2e261f]"

      set -g status-left "#[fg=#da9a22,bg=#2e261f]#[bg=#da9a22,fg=#2e261f,bold]#S#[fg=#da9a22,bg=#2e261f] "

      set -g status-right "#[fg=#4197b9,bg=#2e261f]#[bg=#4197b9,fg=#2e261f,bold]#h#[fg=#4197b9,bg=#2e261f]"
      set -g mouse on
    '';
  };
}

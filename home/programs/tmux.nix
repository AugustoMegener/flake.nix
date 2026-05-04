{pkgs, ...}: 
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      { plugin = resurrect; extraConfig = ''
        set -g @resurrect-strategy-nvim 'session' 
      ''; }
      { plugin = continuum; extraConfig = ''set -g @continuum-restore 'off'
      ''; }
    ];

    extraConfig = ''
      set -g status-style "bg=default,fg=#9c7d5e"

      set -g status-position top
      set -g status-justify left

      set -g window-status-format "#[fg=#9c7d5e,bg=#302b24] #I #W "
      set -g window-status-current-format "#[fg=#40392d,bg=#302b24]#[bg=#40392d,fg=#d5bea1,bold]#I#[bg=#f25146,fg=#40392d,bold]#[fg=#302b24,bg=#f25146] #W#[fg=#f25146,bg=#302b24]"

      set -g status-left "#[fg=#da9a22,bg=#302b24]#[bg=#da9a22,fg=#302b24,bold]#S#[fg=#da9a22,bg=#302b24] "

      set -g status-right "#[fg=#4396b7,bg=#302b24]#[bg=#4396b7,fg=#302b24,bold]#h#[fg=#4396b7,bg=#302b24]"
    '';
  };
}

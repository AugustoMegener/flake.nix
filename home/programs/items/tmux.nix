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
      set -gq allow-passthrough on 
      set-hook -g client-detached 'run-shell "tmux list-panes -t \"#S\" -F \"#{pane_pid}\" | while read pid; do ps -s \$pid -o comm=; done | grep -vE \"^(zsh|yazi)$\" | grep -q . || tmux kill-session -t \"#S\""'
      setw -g mode-keys vi
      
      set -g base-index 1
      set -g renumber-windows on

      unbind C-b
      set -g prefix M-Space
      bind M-Space send-prefix

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

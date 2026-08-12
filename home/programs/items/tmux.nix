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
    '';
  };
}

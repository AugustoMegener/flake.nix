TMUX_TMPDIR=$XDG_RUNTIME_DIR tmux kill-session -t yazi 2>/dev/null
sleep 0.1
TMUX_TMPDIR=$XDG_RUNTIME_DIR tmux new-session -s yazi "zsh -ic 'cd ~ && y; exec zsh'"

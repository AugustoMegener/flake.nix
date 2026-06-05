
if [[ -z "$tmux" && $- == *i* && "$term" != "dumb" && -z "$zsh_execution_string" ]]; then
  if tmux list-sessions -f '#{session_name}:#{session_attached}' 2>/dev/null | grep -v '^yazi:' | grep ':0$' | head -1 | grep -q .; then
    exec tmux attach-session -t "$(tmux list-sessions -f '#{session_name}:#{session_attached}' 2>/dev/null | grep -v '^yazi:' | grep ':0$' | head -1 | cut -d: -f1)"
  else
    exec tmux new-session -s "$(tmux-next-session)"
  fi
fi

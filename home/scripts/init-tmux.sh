#!/usr/bin/env bash

if [[ -z "$TMUX" && $- == *i* && "$TERM" != "dumb" && -z "$ZSH_EXECUTION_STRING" ]]; then
  if tmux list-sessions -F '#{session_name}:#{session_attached}' 2>/dev/null | grep -v '^yazi:' | grep ':0$' | head -1 | grep -q .; then
    exec tmux attach-session -t "$(tmux list-sessions -F '#{session_name}:#{session_attached}' 2>/dev/null | grep -v '^yazi:' | grep ':0$' | head -1 | cut -d: -f1)"
  else
    exec tmux new-session -s "$(tmux-next-session)"
  fi
fi

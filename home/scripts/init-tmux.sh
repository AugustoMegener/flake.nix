cmd="$*"

if [[ -z "$TMUX" && "$term" != "dumb" && -z "$zsh_execution_string" ]]; then

  if [[ -n "$cmd" ]]; then
    tmux new-session -s "$(tmux-next-session)" "$cmd; exec zsh"
  else
    target="$(tmux list-sessions -F '#{session_name}:#{session_attached}' | grep -v '^yazi:' | grep ':0$' | head -1 | cut -d: -f1)"

    if [[ -n "$target" ]]; then
      tmux attach-session -t "$target"
    else
      tmux new-session -s "$(tmux-next-session)"
    fi
  fi

fi

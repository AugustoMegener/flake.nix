cmd="$*"

if [[ -z "$tmux" && "$term" != "dumb" && -z "$zsh_execution_string" ]]; then
  target="$(tmux list-sessions -f '#{session_name}:#{session_attached}' 2>/dev/null | grep -v '^yazi:' | grep ':0$' | head -1 | cut -d: -f1)"

  if [[ -n "$target" ]]; then
    tmux attach-session -t "$target"
  else
    if [[ -n "$cmd" ]]; then
      tmux new-session -s "$(tmux-next-session)" "$cmd; exec zs

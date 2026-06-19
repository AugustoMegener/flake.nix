#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_SESSION_FINDER="$(command -v tmux-session-finder || echo "$SCRIPT_DIR/tmux-session-finder.sh")"

FILE=$(realpath "$@")
if [[ -d "$FILE" ]]; then
  DIR="$FILE"
  TARGET="$FILE"
  MODE="dir"
else
  DIR=$(dirname "$FILE")
  TARGET="$FILE"
  MODE="file"
fi

tmux_chdir() {
  local newdir=$1
  local curr_session
  curr_session=$(tmux display -p '#S')
  local tmp_session
  tmp_session=$(cat /dev/urandom | tr -dc 'A-Z0-9' | head -c 8)
  local width height
  width=$(tmux display -p '#{window_width}')
  height=$(tmux display -p '#{window_height}')
  local initial_clients
  initial_clients=$(tmux list-clients -t "$curr_session" 2>/dev/null | wc -l)
  tmux new-session -d -s "$tmp_session" -x "$width" -y "$height"
  tmux send-keys -t "$tmp_session" "unset TMUX && tmux attach-session -t '$curr_session' -c '$newdir'" Enter
  (
    while [[ $(tmux list-clients -t "$curr_session" 2>/dev/null | wc -l) -le $initial_clients ]]; do
      sleep 0.05
    done
    tmux kill-session -t "$tmp_session" 2>/dev/null
  ) &
  disown
}

open_in_current() {
  if [[ -n "$TMUX" ]]; then
    tmux_chdir "$DIR"
  fi
  if [[ -f "$DIR/flake.nix" ]] && nix flake show "$DIR" --json 2>/dev/null | grep -q '"devShells"'; then
    exec nix develop "$DIR" -c zsh -ic "cd '$DIR' && $EDITOR '$TARGET'"
  else
    exec bash -c "cd '$DIR' && exec $EDITOR '$TARGET'"
  fi
}

if [[ -n "$TMUX" ]]; then
  target_session=$("$TMUX_SESSION_FINDER" "$MODE" "$TARGET")
  if [[ -n "$target_session" ]]; then
    exec tmux switch-client -t "$target_session"
  else
    open_in_current
  fi
else
  open_in_current
fi

#!/usr/bin/env bash

set -u

export TMUX_TMPDIR="/run/user/$(id -u)"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_SESSION_FINDER="$(command -v tmux-session-finder || echo "$SCRIPT_DIR/tmux-session-finder.sh")"
TMUX_NEXT_SESSION="$(command -v tmux-next-session || echo "$SCRIPT_DIR/tmux-next-session.sh")"

RAW="$1"
FILE=$(realpath "$RAW")

if [[ ! -d "$FILE" ]]; then
  exec xdg-open "$FILE"
fi

DIR="$FILE"
TARGET="$FILE"
MODE="dir"

target_session=$("$TMUX_SESSION_FINDER" "$MODE" "$TARGET")

if [[ -n "$target_session" ]]; then
  exec env -u TMUX -u KITTY_WINDOW_ID -u KITTY_LISTEN_ON \
    kitty -e tmux attach-session -t "$target_session"
fi

SESSION=$("$TMUX_NEXT_SESSION")

tmux new-session -d -s "$SESSION" -c "$DIR" "zsh -i"

if [[ -f "$DIR/flake.nix" ]]; then
  CMD="nix develop '$DIR' -c zsh -ic \"cd '$DIR' && $EDITOR '$TARGET'\" || (cd '$DIR' && exec $EDITOR '$TARGET')"
else
  CMD="sleep 0.1; y '$TARGET'"
fi

tmux send-keys -t "$SESSION" "$CMD" Enter

exec env -u TMUX -u KITTY_WINDOW_ID -u KITTY_LISTEN_ON \
  kitty -e tmux attach-session -t "$SESSION"

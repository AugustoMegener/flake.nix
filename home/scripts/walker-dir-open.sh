#!/usr/bin/env bash
# walker-dir-open.sh <pasta-ou-arquivo>
# Handler de "abrir" pra diretórios: se tiver flake.nix com devShell, abre nvim
# dentro da nix shell; senão abre yazi puro. Sempre dentro de uma sessão tmux
# nova (ou reaproveitada) e num kitty novo, já que é chamado fora de terminal.
# Espera tmux-session-finder.sh e tmux-next-session.sh no mesmo diretório.

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
  kitty -e env -u TMUX tmux attach-session -t "$target_session" >/dev/null 2>&1 &
  disown
  exit 0
fi

SESSION=$("$TMUX_NEXT_SESSION")

if [[ -f "$DIR/flake.nix" ]]; then
  CMD="cd '$DIR' && (nix develop '$DIR' -c zsh -ic \"cd '$DIR' && $EDITOR '$TARGET'\" || (cd '$DIR' && exec $EDITOR '$TARGET'))"
else
  CMD="cd '$DIR' && exec yazi '$TARGET'"
fi

tmux new-session -d -s "$SESSION" -c "$DIR"
tmux send-keys -t "$SESSION" "$CMD" Enter

kitty -e env -u TMUX tmux attach-session -t "$SESSION" >/dev/null 2>&1 &
disown

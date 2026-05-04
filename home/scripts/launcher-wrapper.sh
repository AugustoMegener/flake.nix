#!/usr/bin/env bash

GAME_BIN="$1"
shift
"$@" &
wait $!

while ! pgrep -x "$GAME_BIN" > /dev/null; do
  sleep 0.125
done

while pgrep -x "$GAME_BIN" > /dev/null; do
  sleep 0.25
done

#!/usr/bin/env bash
# Imprime o menor número de sessão tmux ainda não usado.

N=0
while tmux has-session -t "$N" 2>/dev/null; do
  N=$((N + 1))
done
echo $N

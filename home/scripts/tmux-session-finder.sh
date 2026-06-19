#!/usr/bin/env bash
# Uso: tmux-session-finder.sh <file|dir> <TARGET>
# Procura uma sessão tmux que já tenha nvim aberto no TARGET.
# Imprime o nome da sessão (stdout) se achar, ou nada caso contrário.

MODE=$1
TARGET=$2

find_nvim_pid() {
  local pane_pid=$1
  local children
  children=$(pgrep -P "$pane_pid" 2>/dev/null)
  for child in $children; do
    local name cmd
    name=$(ps -p "$child" -o comm= 2>/dev/null)
    cmd=$(ps -p "$child" -o cmd= 2>/dev/null)
    if [[ "$name" == "nvim" ]] && [[ "$cmd" != *"--embed"* ]]; then
      echo "$child"
      return
    fi
    local found
    found=$(find_nvim_pid "$child")
    if [[ -n "$found" ]]; then
      echo "$found"
      return
    fi
  done
}

nvim_target() {
  local pid=$1
  local cmdline
  cmdline=$(cat /proc/$pid/cmdline 2>/dev/null | tr '\0' '\n')
  local last_path
  last_path=$(echo "$cmdline" | grep -E '^/' | grep -v '^/nix/store' | tail -1)
  if [[ -n "$last_path" ]]; then
    echo "$last_path"
  else
    readlink /proc/$pid/cwd 2>/dev/null
  fi
}

find_session() {
  local current_session
  current_session=$(tmux display-message -p '#S' 2>/dev/null)
  while IFS=' ' read -r session pane_pid; do
    [[ "$session" == "$current_session" ]] && continue
    local nvim_pid
    nvim_pid=$(find_nvim_pid "$pane_pid")
    [[ -z "$nvim_pid" ]] && continue
    local open_target
    open_target=$(nvim_target "$nvim_pid")
    [[ -z "$open_target" ]] && continue
    if [[ "$MODE" == "file" ]]; then
      [[ "$open_target" == "$TARGET" ]] && echo "$session" && return
    else
      local cwd
      cwd=$(readlink /proc/$nvim_pid/cwd 2>/dev/null)
      [[ "$cwd" == "$TARGET" ]] && echo "$session" && return
    fi
  done < <(tmux list-panes -aF '#{session_name} #{pane_pid}' 2>/dev/null)
}

find_session

#!/usr/bin/env bash

MODE=$1
TARGET=$2

declare -A PPID_OF
declare -A COMM_OF
declare -A CHILDREN_OF

while read -r pid ppid comm; do
  PPID_OF[$pid]="$ppid"
  COMM_OF[$pid]="$comm"
  CHILDREN_OF[$ppid]+="$pid "
done < <(ps -eo pid=,ppid=,comm=)

find_nvim_pid() {
  local root=$1
  local queue=("$root")
  local i=0
  while [[ $i -lt ${#queue[@]} ]]; do
    local pid=${queue[$i]}
    i=$((i + 1))
    for child in ${CHILDREN_OF[$pid]:-}; do
      if [[ "${COMM_OF[$child]:-}" == "nvim" ]]; then
        local cmd
        cmd=$(tr '\0' ' ' < "/proc/$child/cmdline" 2>/dev/null)
        if [[ "$cmd" != *"--embed"* ]]; then
          echo "$child"
          return
        fi
      fi
      queue+=("$child")
    done
  done
}

nvim_target() {
  local pid=$1
  local cmdline
  cmdline=$(tr '\0' '\n' < "/proc/$pid/cmdline" 2>/dev/null)
  local last_path
  last_path=$(echo "$cmdline" | grep -E '^/' | grep -v '^/nix/store' | tail -1)
  if [[ -n "$last_path" ]]; then
    echo "$last_path"
  else
    readlink "/proc/$pid/cwd" 2>/dev/null
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
      cwd=$(readlink "/proc/$nvim_pid/cwd" 2>/dev/null)
      [[ "$cwd" == "$TARGET" ]] && echo "$session" && return
    fi
  done < <(tmux list-panes -aF '#{session_name} #{pane_pid}' 2>/dev/null)
}

find_session

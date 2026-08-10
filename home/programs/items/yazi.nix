{ pkgs, ... }:
let
yaziEdit = pkgs.writeShellScript "yazi-edit" ''
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
    target_session=$(find_session)
    if [[ -n "$target_session" ]]; then
      exec tmux switch-client -t "$target_session"
    else
      open_in_current
    fi
  else
    open_in_current
  fi
'';
in
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    keymap = {
      mgr = {
        prepend_keymap = [
          {
            on = "y";
            run = [
              ''shell -- for path in %s; do echo "file://$path"; done | wl-copy -t text/uri-list''
              "yank"
            ];
          }
        ];
      };
    };

    settings = {

      opener = {
        edit = [
          {
            run = "${yaziEdit} $@";
            block = true;
          }
        ];
      };
    };

    theme = {
      border-style = {
        fg = "#866f50";
      };

      mgr = {
        marker_marked = {
          fg = "#9595d9";
          bg = "#2e261f";
        };
      };

      mode = {
        normal_main = {
          bold = true;
          bg = "#da9a22";
          fg = "#2e261f";
        };
        select_main = {
          bold = true;
          bg = "#9595d9";
          fg = "#2e261f";
        };

        normal_alt = {
          bg = "#342c23";
        };
        select_alt = {
          bg = "#342c23";
        };
        unset_alt = {
          bg = "#342c23";
        };
        unset_main = {
          bold = true;
          bg = "#342c23";
        };
      };

      indicator = {
        parent = {
          fg = "#2e261f";
          bg = "#da9a22";
        };
        current = {
          fg = "#2e261f";
          bg = "#f25146";
        };
        preview = {
          fg = "#2e261f";
          bg = "#4197b9";
        };
      };

      filetype = {
        rules = [
          {
            url = "*/";
            fg = "#866f50";
            bold = true;
          }
        ];
      };

      icon = {
        dirs = [
          {
            name = ".config";
            text = "";
            fg = "#ff9800";
          }
          {
            name = ".git";
            text = "";
            fg = "#866f50";
          }
          {
            name = ".github";
            text = "";
            fg = "#03a9f4";
          }
          {
            name = ".npm";
            text = "";
            fg = "#03a9f4";
          }
          {
            name = "Desktop";
            text = "";
            fg = "#866f50";
          }
          {
            name = "Developer";
            text = "󰲋";
            fg = "#866f50";
          }
          {
            name = "Vault";
            text = "";
            fg = "#866f50";
          }
          {
            name = "System";
            text = "";
            fg = "#866f50";
          }
          {
            name = "Documents";
            text = "";
            fg = "#866f50";
          }
          {
            name = "Downloads";
            text = "";
            fg = "#866f50";
          }
          {
            name = "Library";
            text = "";
            fg = "#866f50";
          }
          {
            name = "Movies";
            text = "";
            fg = "#866f50";
          }
          {
            name = "Games";
            text = "󰊴";
            fg = "#866f50";
          }
          {
            name = "Music";
            text = "";
            fg = "#866f50";
          }
          {
            name = "Pictures";
            text = "";
            fg = "#866f50";
          }
          {
            name = "Public";
            text = "";
            fg = "#866f50";
          }
          {
            name = "Videos";
            text = "";
            fg = "#866f50";
          }
        ];
        conds = [
          {
            "if" = "dir & hovered";
            text = "";
            fg = "#866f50";
          }
          {
            "if" = "dir";
            text = "";
            fg = "#866f50";
          }
          {
            "if" = "!dir";
            text = "";
            fg = "white";
          }
        ];
      };
    };

    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
    };
    initLua = ''
      require("full-border"):setup()
      require("zoxide"):setup {
        update_db = true,
      }
    '';
  };
}

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
  tmux new-session -d -s "$tmp_session"
  tmux send-keys -t "$tmp_session" "unset TMUX && tmux attach-session -t '$curr_session' -c '$newdir' && tmux refresh-client && tmux kill-session -t '$tmp_session'" Enter
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
      border_style = {
        fg = "#aa906d";
      };

      mgr = {
        marker_marked = {
          fg = "#9595d9";
          bg = "#302b24";
        };
      };

      mode = {
        normal_main = {
          bold = true;
          bg = "#f29554";
          fg = "#302b24";
        };
        select_main = {
          bold = true;
          bg = "#9595d9";
          fg = "#302b24";
        };

        normal_alt = {
          bg = "#40392d";
        };
        select_alt = {
          bg = "#40392d";
        };
        unset_alt = {
          bg = "#40392d";
        };
        unset_main = {
          bold = true;
          bg = "#40392d";
        };
      };

      indicator = {
        parent = {
          fg = "#302b24";
          bg = "#f29554";
        };
        current = {
          fg = "#302b24";
          bg = "#f25146";
        };
        preview = {
          fg = "#302b24";
          bg = "#4396b7";
        };
      };

      filetype = {
        rules = [
          {
            url = "*/";
            fg = "#aa906d";
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
            fg = "#aa906d";
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
            fg = "#aa906d";
          }
          {
            name = "Developer";
            text = "󰲋";
            fg = "#aa906d";
          }
          {
            name = "Vault";
            text = "";
            fg = "#aa906d";
          }
          {
            name = "System";
            text = "";
            fg = "#aa906d";
          }
          {
            name = "Documents";
            text = "";
            fg = "#aa906d";
          }
          {
            name = "Downloads";
            text = "";
            fg = "#aa906d";
          }
          {
            name = "Library";
            text = "";
            fg = "#aa906d";
          }
          {
            name = "Movies";
            text = "";
            fg = "#aa906d";
          }
          {
            name = "Music";
            text = "";
            fg = "#aa906d";
          }
          {
            name = "Pictures";
            text = "";
            fg = "#aa906d";
          }
          {
            name = "Public";
            text = "";
            fg = "#aa906d";
          }
          {
            name = "Videos";
            text = "";
            fg = "#aa906d";
          }
        ];
        conds = [
          {
            "if" = "dir & hovered";
            text = "";
            fg = "#aa906d";
          }
          {
            "if" = "dir";
            text = "";
            fg = "#aa906d";
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

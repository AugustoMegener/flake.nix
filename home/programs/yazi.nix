{ pkgs, ... }:
let
  yaziEdit = pkgs.writeShellScript "yazi-edit" ''
    #!/bin/bash
    FILE=$(realpath "$@")
    CLIENT=$(tmux display-message -p -t "$TMUX_PANE" '#{client_name}')
    RETURN=$(tmux display-message -p -t "$TMUX_PANE" '#{session_name}')

    if [[ -d "$FILE" ]]; then
      DIR="$FILE"
    else
      DIR=$(dirname "$FILE")
    fi

    if [[ -f "$DIR/flake.nix" ]] && nix flake show "$DIR" --json 2>/dev/null | grep -q '"devShells"'; then
      SHELL_CMD="nix develop '$DIR' -c zsh -c \"$EDITOR '$FILE'; tmux switch-client -c '$CLIENT' -t '$RETURN'; tmux kill-session -t '$SESSION'\""
    else
      SHELL_CMD="zsh -c \"cd '$DIR' && $EDITOR '$FILE'; tmux switch-client -c '$CLIENT' -t '$RETURN'; tmux kill-session -t '$SESSION'\""
    fi

    EXISTING=$(tmux list-sessions -F '#{session_name}' 2>/dev/null | while read s; do
      tmux show-environment -t "$s" YAZI_FILE 2>/dev/null | grep -qF "YAZI_FILE=$FILE" && echo "$s"
    done)

    if [[ -n "$EXISTING" ]]; then
      tmux switch-client -c "$CLIENT" -t "$EXISTING"
    else
      SESSION=$(tmux-next-session)
      tmux new-session -d -s "$SESSION" -c "$DIR" -e "YAZI_FILE=$FILE" "$SHELL_CMD"
      tmux switch-client -c "$CLIENT" -t "$SESSION"
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
    '';
  };
}

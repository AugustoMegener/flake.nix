{ pkgs, ... }:
{
  programs.yazi = {

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
    '';
  };
}

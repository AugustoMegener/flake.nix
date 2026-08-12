{ pkgs, ... }:
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
            run = "yaziEdit $@";
            block = true;
          }
        ];
      };
    };

    initLua = ''
      require("zoxide"):setup {
        update_db = true,
      }
    '';
  };
}

{ lib, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    sessionVariables = {
      TMUX_TMPDIR = "$XDG_RUNTIME_DIR";
    };
    initContent = lib.mkAfter ''
    '';
  };
}

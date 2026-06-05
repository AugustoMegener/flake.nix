{ lib, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    sessionVariables = {
      TMUX_TMPDIR = "$XDG_RUNTIME_DIR";
      FZF_DEFAULT_OPTS=''$'--border=rounded
        --list-border=rounded
        --preview-border=rounded
        --color=fg:#d5bea1,bg:#302b24,hl:#da9a22,fg+:#ebdbb2,bg+:#3c3836
        --color=hl+:#fabd2f,info:#4396b7,prompt:#bdae93,pointer:#4396b7
        --color=marker:#4396b7,spinner:#da9a22,header:#a89984,border:#d5bea1
        --color=gutter:#3c3836'
      '';
    };
    initContent = lib.mkAfter ''
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi
      '';
  };
}

{ ... }:
{
 programs.fzf = {
    enable = true;
    defaultOptions = [
      "--border=rounded"
      "--list-border=rounded"
      "--preview-border=rounded"
      "--color=fg:#d7c0a3,bg:#2e261f,hl:#da9a22,fg+:#ebdbb2,bg+:#3c3836"
      "--color=hl+:#fabd2f,info:#4197b9,prompt:#bdae93,pointer:#4197b9"
      "--color=marker:#4197b9,spinner:#da9a22,header:#a89984,border:#d7c0a3"
      "--color=gutter:#3c3836"
    ];
    enableZshIntegration = true; 
  };
}

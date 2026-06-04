{ ... }:
{
  programs.git = {
    enable = true;
    userName = "AugustoMegener";
    userEmail = "76854495+AugustoMegener@users.noreply.github.com";
    settings.credential.helper = "!gh auth git-credential";
  };
}

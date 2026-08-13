{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      credential.helper = "!gh auth git-credential";
      user = {
        name = "AugustoMegener";
        email = "76854495+AugustoMegener@users.noreply.github.com";
      };
    };
  };
}

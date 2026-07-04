{ config, pkgs, lib, ... }:
let
  neomd = pkgs.buildGoModule {
    pname = "neomd";
    version = "unstable-2026-07-04";
    src = pkgs.fetchFromGitHub {
      owner = "ssp-data";
      repo = "neomd";
      rev = "main";
      hash = "sha256-fRTqx2JzDCV9lz6pnqwrc4MWHYoTJjLkWjYGtXLA6FI=";
    };
    vendorHash = "sha256-8RFnVKCpmIoZRskq8aHIOnaj7xN33Au4QoQNHhBPmBU=";
    meta = {
      description = "Keyboard-first TUI email client, compose in Markdown via Neovim";
      homepage = "https://github.com/ssp-data/neomd";
      license = pkgs.lib.licenses.mit;
      mainProgram = "neomd";
    };
  };

  neomdConfig = {
    store_sent_drafts_in_sending_account = false;
    auto_bcc = "";
    accounts =[{
      name = "Personal";
      imap = "imap.gmail.com:993";
      smtp = "smtp.gmail.com:587";
      user = config.sops.placeholder."neomd/user";
      password = config.sops.placeholder."neomd/password";
      from = config.sops.placeholder."neomd/from";
      starttls = false;
      tls_cert_file = "";
      imap_disabled = false;
      auth_type = "";
      oauth2_client_id = "";
      oauth2_client_secret = "";
      oauth2_issuer_url = "";
      oauth2_auth_url = "";
      oauth2_token_url = "";
      oauth2_redirect_port = 0;
      signature_block = {
        text = "";
        html = "";
      };
    }];
    screener = {
      screened_in = "${config.home.homeDirectory}/.config/neomd/lists/screened_in.txt";
      screened_out = "${config.home.homeDirectory}/.config/neomd/lists/screened_out.txt";
      feed = "${config.home.homeDirectory}/.config/neomd/lists/feed.txt";
      papertrail = "${config.home.homeDirectory}/.config/neomd/lists/papertrail.txt";
      spam = "${config.home.homeDirectory}/.config/neomd/lists/spam.txt";
      notify = "${config.home.homeDirectory}/.config/neomd/lists/notify.txt";
    };
    folders = {
      inbox = "INBOX";
      sent = "Sent";
      trash = "Trash";
      drafts = "Drafts";
      to_screen = "ToScreen";
      feed = "Feed";
      papertrail = "PaperTrail";
      screened_out = "ScreenedOut";
      archive = "Archive";
      waiting = "Waiting";
      scheduled = "Scheduled";
      someday = "Someday";
      spam = "Spam";
      work = "";
    };
    ui = {
      theme = "kanagawa";
      inbox_count = 200;
      signature = "*sent from [neomd](https://neomd.ssp.sh)*";
      bg_sync_interval = 5;
      bulk_progress_threshold = 0;
      draft_backup_count = 0;
      mark_as_read_after_secs = 7;
      signature_block.text = "";
      html = "";
    };
    notifications = {
      enabled = false;
      command = "notify-send";
      icon = "mail-message-new";
      expire_ms = 5000;
      folders = ["Inbox"];
    };
    ai = {
      command = "claude";
      args = ["edit {file}: {prompt}"];
    };
    theme = {
      bg = "";
      border = "";
      subtle = "";
      selected = "";
      text = "";
      muted = "";
      primary = "";
      unread = "";
      number = "";
      date = "";
      author_read = "";
      subject_read = "";
      size_col = "";
      author_unread = "";
      subject_unread = "";
      error = "";
      success = "";
    };
    calendar.open_command = "";
    listmonk = {
      url = "";
      api_user = "";
      api_token = "";
      delay_minutes = 0;
    };
  };
in
{

  home.packages = [ neomd ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.age.keyFile = "/home/kito/.config/sops/age/keys.txt";
  sops.secrets."neomd/user" = {};
  sops.secrets."neomd/password" = {};
  sops.secrets."neomd/from" = {};

  sops.templates."neomd-config.toml".content =
    builtins.readFile ((pkgs.formats.toml { }).generate "neomd-config" neomdConfig);
  home.activation.linkNeomdConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/neomd"
    ln -sf "${config.sops.templates."neomd-config.toml".path}" "$HOME/.config/neomd/config.toml"
  '';
}


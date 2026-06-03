{ config, pkgs, lib, ... }:

let
  username = "kito";
  gameFile = "/home/${username}/.local/share/gamescope-boot/next-game";

  sessionScript = pkgs.writeShellScript "greetd-session" ''
    if [ -f "${gameFile}" ] && grep -q noresume /proc/cmdline; then
      GAME=$(cat "${gameFile}")
      rm "${gameFile}"
      ${lib.getExe pkgs.gamescope} -W 1920 -H 1080 -f -e -- $GAME || true
      systemctl reboot
    else
      exec start-hyprland
    fi
  '';
in
{
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${sessionScript}";
        user = username;
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd start-hyprland";
        user = "greeter";
      };
    };
  };

  specialisation.gamescope.configuration = {
    boot.kernelParams = lib.mkForce (
      (lib.filter
        (p: p != "resume" && !(lib.hasPrefix "resume=" p))
        config.boot.kernelParams)
      ++ [ "noresume" ]
    );
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "game-launch" ''
      if [ $# -eq 0 ]; then
        echo "uso: game-launch <binário> [args...]" >&2
        exit 1
      fi

      mkdir -p "$(dirname "${gameFile}")"
      echo "$*" > "${gameFile}"

      ENTRY=$(ls /boot/loader/entries/ 2>/dev/null \
        | grep "specialisation-gamescope" \
        | sort -V | tail -1 \
        | sed 's/\.conf$//')

      if [ -z "$ENTRY" ]; then
        rm "${gameFile}"
        echo "erro: entrada gamescope não encontrada em /boot/loader/entries/" >&2
        exit 1
      fi

      sudo ${pkgs.systemd}/bin/bootctl set-oneshot "$ENTRY"
      systemctl hibernate
    '')
  ];

  security.sudo.extraRules = [{
    users = [ username ];
    commands = [{
      command = "${pkgs.systemd}/bin/bootctl";
      options = [ "NOPASSWD" ];
    }];
  }];
}

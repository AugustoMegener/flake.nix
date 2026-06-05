{ config, pkgs, lib, ... }:
let
  username = "kito";
  gameFile = "/home/${username}/.local/share/gamescope-boot/next-game";
  backupFile = "/boot/loader/entries/.nixos-normal-options.bak";

  sessionScript = pkgs.writeShellScript "greetd-session" ''
    if [ -f "${gameFile}" ] && grep -q noresume /proc/cmdline; then
      GAME=$(cat "${gameFile}")
      rm "${gameFile}"
      ${lib.getExe pkgs.gamescope} -W 1920 -H 1080 -f -- $GAME || true

      CURRENT_ENTRY=$(ls /boot/loader/entries/ \
        | grep -v specialisation \
        | grep "^nixos" \
        | sort -V | tail -1)

      if [ -f "${backupFile}" ]; then
        sudo cp "${backupFile}" "/boot/loader/entries/$CURRENT_ENTRY"
        sudo rm "${backupFile}"
      fi

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
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --cmd start-hyprland";
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
    pkgs.efibootmgr
    (pkgs.writeShellScriptBin "game-launch" ''
      set -euo pipefail

      if [ $# -eq 0 ]; then
        echo "uso: game-launch <binário> [args...]" >&2
        exit 1
      fi

      CURRENT_ENTRY=$(ls /boot/loader/entries/ \
        | grep -v specialisation \
        | grep "^nixos" \
        | sort -V | tail -1)

      GAMESCOPE_ENTRY=$(ls /boot/loader/entries/ \
        | grep "specialisation-gamescope" \
        | sort -V | tail -1)

      CURRENT_PATH="/boot/loader/entries/$CURRENT_ENTRY"
      GAMESCOPE_PATH="/boot/loader/entries/$GAMESCOPE_ENTRY"

      GAMESCOPE_INIT=$(grep "^options" "$GAMESCOPE_PATH" | grep -o 'init=[^ ]*')
      GAMESCOPE_OPTIONS=$(grep "^options" "$GAMESCOPE_PATH" | sed 's/^options //')

      sudo cp "$CURRENT_PATH" "${backupFile}"

      sudo ${pkgs.gnused}/bin/sed -i \
        "s|^options .*|options $GAMESCOPE_OPTIONS|" \
        "$CURRENT_PATH"

      mkdir -p "$(dirname "${gameFile}")"
      echo "$*" > "${gameFile}"

      systemctl hibernate
    '')
  ];

  security.sudo.extraRules = [{
    users = [ username ];
    commands = [
      {
        command = "${pkgs.efibootmgr}/bin/efibootmgr";
        options = [ "NOPASSWD" ];
      }
      {
        command = "${pkgs.coreutils}/bin/cp";
        options = [ "NOPASSWD" ];
      }
      {
        command = "${pkgs.coreutils}/bin/rm";
        options = [ "NOPASSWD" ];
      }
      {
        command = "${pkgs.gnused}/bin/sed";
        options = [ "NOPASSWD" ];
      }
    ];
  }];
}

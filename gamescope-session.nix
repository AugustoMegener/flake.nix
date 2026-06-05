{ config, pkgs, lib, ... }:
let
  username = "kito";
  gameFile = "/home/${username}/.local/share/gamescope-boot/next-game";

  sessionScript = pkgs.writeShellScript "greetd-session" ''
    if [ -f "${gameFile}" ] && grep -q noresume /proc/cmdline; then
      GAME=$(cat "${gameFile}")
      rm "${gameFile}"
      ${lib.getExe pkgs.gamescope} -W 1920 -H 1080 -f -- $GAME || true
      sudo ${pkgs.efibootmgr}/bin/efibootmgr --bootorder 0001,000F,000E,0009
      systemctl reboot
    else
      exec ${lib.getExe config.programs.hyprland.package}
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

      ENTRY_FILE=$(ls /boot/loader/entries/ \
        | grep "specialisation-gamescope" \
        | sort -V | tail -1)
      ENTRY_PATH="/boot/loader/entries/$ENTRY_FILE"

      LINUX=$(grep "^linux " "$ENTRY_PATH" | awk '{print $2}' | tr '/' '\\')
      INITRD=$(grep "^initrd " "$ENTRY_PATH" | awk '{print $2}' | tr '/' '\\')
      OPTIONS=$(grep "^options " "$ENTRY_PATH" | sed 's/^options //')

OLD=$(sudo ${pkgs.efibootmgr}/bin/efibootmgr \
  | grep "NixOS Gamescope" \
  | grep -o 'Boot[0-9A-F]\{4\}' \
  | sed 's/Boot//' \
  | tr -d '[:space:]') || OLD=""

if [ -n "$OLD" ]; then
  sudo ${pkgs.efibootmgr}/bin/efibootmgr --delete-bootnum "$OLD" > /dev/null
fi

      sudo ${pkgs.efibootmgr}/bin/efibootmgr \
        --create --disk /dev/sda --part 1 \
        --label "NixOS Gamescope" \
        --loader "$LINUX" \
        --unicode "initrd=$INITRD $OPTIONS" > /dev/null

      sudo ${pkgs.efibootmgr}/bin/efibootmgr \
        --bootorder 0000,0001,000F,000E,0009 > /dev/null

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
    ];
  }];
}

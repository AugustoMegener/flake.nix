# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:
let

in
{
  imports = [
    ./hardware-configuration.nix
    ./gamescope-session.nix
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        FastConnectable = true;
      };
    };
  };

  
  boot = {
    kernelModules = [ "btusb" ];
    kernelParams = [ 
      "quiet" 
      "splash"
      "acpi_backlight=native"
      "resume=UUID=1ba095d7-4fc0-461b-a2c4-be8db6e75d96"
    ];
    kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
      lib.mkDefault pkgs.linuxPackages_6_18
    );
    plymouth.enable = true;
  };

  services.blueman.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

# Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Sputnik-I"; # Define your hostname.

# Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;

# Set your time zone.
  time.timeZone = "America/Sao_Paulo";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
#   font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
#   useXkbConfig = true; # use xkb.options in tty.
  };

# Enable the X11 windowing system.
# services.xserver.enable = true;

  environment.variables.EDITOR = "nvim";

# Configure keymap in X11
# services.xserver.xkb.layout = "us";
# services.xserver.xkb.options = "eurosign:e,caps:escape";

# Enable CUPS to print documents.
  services.printing.enable = true;

# Enable sound.
# services.pulseaudio.enable = true;
# OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
    };
  };

# Enable touchpad support (enabled default in most desktopManager).
# services.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kito = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "input"
      "video"
      "audio"
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      efibootmgr
      tree
    ];
  };

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings."org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      }
    ];
  };
# programs.firefox.enable = true;

  programs.hyprland.enable = true;

  services.xserver.enable = true;

  programs.walker = {
    enable = true;
  };

# services.displayManager.sddm.enable = true;

  services.displayManager.defaultSession = "hyprland";

  /*services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
        user = "kito";
      };
    };
  };*/

  hardware.graphics.enable = true;
  security.polkit.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "Adwaita";
  };

  programs.zsh.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;  
    dedicatedServer.openFirewall = true; 
    
  };

  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam.gamescopeSession.enable = true;
  };

  specialisation.gamescope.configuration = {
    boot.kernelParams = [ "noresume" ];
    /*services.greetd.settings.default_session = {
      command = "/etc/greetd/gamescope-autologin";
      user = "kito";
    };*/
  };

  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

# services.pipewire.enable = true;

# List packages installed in system profile.
# You can use https://search.nixos.org/ to find more packages (and options).

  environment.systemPackages = with pkgs; [ 
    xdg-desktop-portal
    gamescope-wsi
  ];

  

  services.dbus.packages = with pkgs; [
    xdg-desktop-portal
      xdg-desktop-portal-hyprland
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.go-mono
      (google-fonts.override { fonts = [ "Bricolage Grotesque" "Domine" ]; })
      twemoji-color-font
  ];

  fonts.fontconfig.defaultFonts = {
    serif = [ "Domine" ];
    sansSerif = [ "Domine" ];
    monospace = [ "GoMono Nerd Font" ];
  };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

# List services that you want to enable:

# Enable the OpenSSH daemon.
  services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
# to actually do that.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

  home-manager.backupFileExtension = "bak";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, lib, userName, hostName, secretFile, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/packages
    ];

  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
  };

  networking.hostName = hostName; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  system.activationScripts.checkAdminPassword = {
    deps = [ "specialfs" ];
    supportsDryActivation = true;
    text = ''
      if [ ! -e "${secretFile}" ]; then
        echo "Failed assertions:" >&2
        echo "- Password file missing: /mnt${secretFile}" >&2
        echo "  Generate it using:" >&2
        echo "    mkdir -p \$(dirname /mnt${secretFile})" >&2
        echo "    nix-shell -p mkpasswd --run \"mkpasswd -m sha-512 > /mnt${secretFile}\"" >&2
        echo "    chmod 600 /mnt${secretFile}" >&2
        exit 1
      fi
    '';
  };

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPasswordFile = secretFile;
    # zsh as the default login shell
    shell = pkgs.zsh;
  };

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # unfree packages: whitelist only (allowUnfree=false, allowUnfreePredicate lists the exceptions)
  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "volatility3"      # memory forensics
    "unrar"            # rar extraction
    # androidenv (objection dependency): composed wrappers use the
    # android-sdk-* prefix, raw archives use the bare package name.
    "android-sdk-cmdline-tools"
    "android-sdk-platform-tools"
    "android-sdk-build-tools"
    "android-sdk-cmake"
    "android-sdk-platforms"
    "android-sdk-sources"
    "android-sdk-tools"
    "android-sdk-emulator"
    "android-sdk-ndk"
    "cmdline-tools"
    "platform-tools"
    "build-tools"
    "cmake"
    "platforms"
    "sources"
    "tools"
    "emulator"
    "ndk"
    "ndk-bundle"
    "extras"
    "patcher"
    "skiaparser"
    "system-images"
    "addons"
  ];
  nixpkgs.config.android_sdk.accept_license = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
    "openclaw-2026.5.7"
  ];

  # Automatic store maintenance
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  # Enable zsh system-wide
  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    openssh
    # xterm-kitty terminfo: fixes zsh line editing over SSH from kitty
    kitty.terminfo
  ];

  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;                   # Systemd service for auto-start
      restartIfChanged = true;         # Auto-restart dms.service when dms-shell changes
    };

    # Core features
    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
  };

  # niri - Wayland compositor. Official module registers the niri session
  # for display managers, sets up xdg portals and gnome-keyring.
  programs.niri = {
    enable = true;
    useNautilus = false; # avoid pulling nautilus; FileChooser falls back to gtk
  };

  services.desktopManager = {
    gnome.enable = true;
  };

  # Display manager: run niri as the desktop session.
  # Active: SDDM graphical login.
  # Alternatives are commented out below; to test one, comment the active
  # block and uncomment the alternative, then nixos-rebuild switch.
  services.displayManager = {
    enable = true;
    gdm.enable = true;
    defaultSession = "niri";
  };
  # Alternative: greetd + tuigreet (TUI login)
  # services.greetd = {
  #   enable = true;
  #   settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember";
  # };

  # Alternative: manual startup (no login manager)
  # Log in on a TTY and run "niri-session".

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}

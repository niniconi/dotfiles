# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, lib, userName, hostName, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/packages
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

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

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
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
    niri
    dms-shell
  ];

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

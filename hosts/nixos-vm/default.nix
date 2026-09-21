# Standalone NixOS VM configuration
# Does NOT import host hardware (disko, tmpfs root, LUKS, etc.)
# Compatible with: nixos-rebuild build-vm --flake .#nixos-vm
{ config, pkgs, lib, hostName, ... }:

{
  imports = [
    ../common/core
    ../common/optional/niri.nix
    ../common/optional/dms.nix
    ../common/optional/security-hardening.nix
    ../common/optional/input-method.nix
    ../common/optional/programs.nix
    ../common/optional/ssh.nix
    ../common/optional/sing-box.nix
    ../common/optional/wireguard.nix
    ../common/optional/wireshark.nix
    ../common/packages
  ];

  # Allow specific insecure packages (same as host)
  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "volatility3"
    "unrar"
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

  # Bootloader (VM uses direct boot, but systemd-boot is still needed)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;

  networking.hostName = hostName;

  # User account with initial password (no sops-nix in VM)
  users.users.administrator = {
    isNormalUser = true;
    description = "administrator";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "test";
    shell = pkgs.zsh;
  };

  # System packages (synced with host)
  environment.systemPackages = with pkgs; [
    neovim
    openssh
    kitty.terminfo
    git
    htop
  ];

  # zramSwap (same as host, without physical swapfile)
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    priority = 100;
  };

}

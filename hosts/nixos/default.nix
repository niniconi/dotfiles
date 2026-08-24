{ config, pkgs, lib, userName, hostName, diskDevice, secretFile, ... }:

{
  imports = [
    ../common/core
    ../common/optional/niri.nix
    ../common/optional/dms.nix
    ../common/optional/impermanence.nix
    ../common/optional/security-hardening.nix
    ../common/optional/input-method.nix
    ../common/optional/programs.nix
    ../common/optional/ssh.nix
    ../common/optional/sing-box.nix
    ../common/optional/wireguard.nix
    ./hardware.nix
    ../common/packages
  ];

  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
  };

  networking.hostName = hostName;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    openssh
    # xterm-kitty terminfo: fixes zsh line editing over SSH from kitty
    kitty.terminfo
  ];

}

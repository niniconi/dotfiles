{
  pkgs,
  lib,
  hostName,
  users,
  ...
}:

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
    ../common/optional/valent.nix
    ../common/optional/swap.nix
    ../common/optional/wireguard.nix
    ../common/optional/wireshark.nix
    ./hardware.nix
    ../common/packages
  ];

  # Bootloader.
  boot = {
    loader = {
      grub.enable = false;
      systemd-boot.enable = lib.mkForce false;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  networking.hostName = hostName;

  # Check if all user password files exist
  system.activationScripts.checkPasswords = {
    deps = [ "specialfs" ];
    supportsDryActivation = true;
    text = lib.concatStrings (
      lib.mapAttrsToList (userName: userConf: ''
        if [ ! -e "${userConf.passwordFile}" ]; then
          echo "Failed assertions:" >&2
          echo "- Password file missing for user ${userName}: /mnt${userConf.passwordFile}" >&2
          echo "  Generate it using:" >&2
          echo "    mkdir -p \$(dirname /mnt${userConf.passwordFile})" >&2
          echo "    nix-shell -p mkpasswd --run \"mkpasswd -m sha-512 > /mnt${userConf.passwordFile}\"" >&2
          echo "    chmod 600 /mnt${userConf.passwordFile}" >&2
          exit 1
        fi
      '') users
    );
  };

  # unfree packages: whitelist only (allowUnfree=false, allowUnfreePredicate lists the exceptions)
  nixpkgs.config = {
    allowUnfree = false;
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "volatility3" # memory forensics
        "unrar" # rar extraction
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
    android_sdk.accept_license = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
      "openclaw-2026.5.7"
    ];
  };

  # Define user accounts (from hosts.nix manifest via users parameter)
  users.users = lib.mapAttrs (userName: userConf: {
    isNormalUser = true;
    description = userName;
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
    ];
    hashedPasswordFile = userConf.passwordFile;
    shell = pkgs.zsh;
  }) users;

}

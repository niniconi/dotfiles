# Host policy: accounts, hostname, bootloader and the root filesystem. Add
# your hardware and disk layout here as well.
{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.hostName = config.dotfiles.hostName;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Placeholder root; replace with your real disk layout (disko, tmpfs, ...).
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  users.users = lib.mapAttrs (userName: userConf: {
    isNormalUser = true;
    description = userName;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = userConf.passwordFile;
    shell = pkgs.zsh;
  }) config.dotfiles.users;
}

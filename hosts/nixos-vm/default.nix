# Standalone NixOS VM configuration
# Does NOT import host hardware (disko, tmpfs root, LUKS, etc.)
# Compatible with: nixos-rebuild build-vm --flake .#nixos-vm
{
  pkgs,
  lib,
  hostName,
  ...
}:

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
    ../common/optional/valent.nix
    ../common/optional/wireguard.nix
    ../common/optional/wireshark.nix
    ../common/packages
  ];

  # Bootloader (VM uses direct boot, but systemd-boot is still needed)
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.enable = false;
  };

  networking.hostName = hostName;

  # SLiRP keeps the guest on 10.0.2.15, so the host needs a forwarded port to
  # reach it: ssh -p 2222 administrator@127.0.0.1. The QEMU options live in the
  # vmVariant submodule, which is what system.build.vm is built from.
  virtualisation.vmVariant.virtualisation.forwardPorts = [
    {
      from = "host";
      host.address = "127.0.0.1";
      host.port = 2222;
      guest.port = 22;
    }
  ];

  # The shared SSH module keeps sshd off and password auth disabled, and this VM
  # has no sops profiles to pull authorized keys from, so override both.
  services.openssh = {
    enable = lib.mkForce true;
    settings.PasswordAuthentication = lib.mkForce true;
  };

  # netfilter starts at `policy drop` with no ports allowed.
  networking.firewall.allowedTCPPorts = [ 22 ];

  # User account with initial password (no sops-nix in VM)
  users.users.administrator = {
    isNormalUser = true;
    description = "administrator";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    initialPassword = "test";
    shell = pkgs.zsh;
  };

  # zramSwap (same as host, without physical swapfile)
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    priority = 100;
  };

}

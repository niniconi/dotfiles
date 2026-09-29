# nixos-oci - the same desktop, packaged as a container image.
#
# Deliberately not a disk image. The OCI cloud-image path (system.build.OCIImage
# in nixpkgs) produces a qcow2 with a partition table that boots its own kernel,
# and it hardcodes an 8 GiB disk, which is what ran out of space. A container has
# neither: `boot.isContainer` replaces the bootloader with a symlink to /init and
# the host kernel does the booting, so there is no disk to size at all.
#
# Excluded versus the host: hardware.nix (disko, LUKS, btrfs, tmpfs root),
# impermanence.nix (persists to /persist) and swap.nix (zram plus a swapfile on
# /persist). Swap is the host's business; a container cannot set it up anyway.
{
  pkgs,
  lib,
  modulesPath,
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
    (modulesPath + "/virtualisation/docker-image.nix")
  ];

  # Tells nixpkgs the system runs inside a container: no bootloader is installed
  # and the host kernel is used. The host kernel also does the booting, so the
  # kernel hardening in security-hardening.nix is inert at best -- those params
  # are never read, and the sysctls fail on a read-only /proc/sys. What that
  # module also sets (mutableUsers, auto-optimise-store) is portable and stays.
  boot = {
    isContainer = true;
    kernelParams = lib.mkForce [ ];
    kernel.sysctl = lib.mkForce { };
  };
  security.protectKernelImage = lib.mkForce false;

  # Every stock image module (oci, azure, amazon, ...) sets this plainly in a
  # plain assignment, which collides with the shared ssh.nix the moment anything
  # evaluates system.build.images. A container is entered with podman exec, so
  # no sshd.
  services.openssh.enable = lib.mkForce false;

  networking.hostName = hostName;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # No sops profiles on a container image, so there is no password file to read:
  # home-manager still needs the account to exist.
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

  # `nh os build-image --image-variant <name>` builds
  # `config.system.build.images.<name>`, which nixpkgs derives from
  # `image.modules`. nixpkgs already ships `oci` there for Oracle Cloud disk
  # images, which cannot work here anyway (that module forces networkd plus a
  # cloud resolv.conf, which the host's systemd-resolved setup rejects), so this
  # host takes the name over and points it at the container instead.
  image.modules.oci = lib.mkForce (
    {
      config,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [ (modulesPath + "/image/file-options.nix") ];
      # buildLayeredImage's `name` is what ends up on disk and in the loaded image
      # reference, so it matches the flake output rather than anything else here.
      # Cmd is /init because systemd is PID 1 and nixpkgs' own init starts it.
      system.build.image = pkgs.dockerTools.buildLayeredImage {
        name = "nixos-oci";
        tag = "latest";
        contents = [ config.system.build.toplevel ];
        config.Cmd = [ "/init" ];
      };
    }
  );
}

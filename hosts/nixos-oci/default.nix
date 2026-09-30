# nixos-oci - the desktop's packages, packaged as a container filesystem.
#
# Deliberately not a disk image. The OCI cloud-image path (system.build.OCIImage
# in nixpkgs) produces a qcow2 with a partition table that boots its own kernel,
# and it hardcodes an 8 GiB disk, which is what ran out of space. A container has
# neither: nothing boots inside it, so there is no disk to size at all.
#
# Excluded versus the host: hardware.nix (disko, LUKS, btrfs, tmpfs root),
# impermanence.nix (persists to /persist) and swap.nix (zram plus a swapfile on
# /persist), plus whatever minimalPackages drops. Swap is the host's business; a
# container cannot set it up anyway.
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
    let
      # NixOS does not put a shell in the closure: /bin/sh normally appears
      # during activation, and nothing runs activation here.
      shell = pkgs.runCommand "container-shell" { } ''
        mkdir -p $out/bin
        ln -s ${pkgs.bash}/bin/bash $out/bin/sh
      '';

      # Both of these are nixpkgs' own symlink farms, one package per entry, so
      # nothing has to be listed by hand: system.path covers
      # environment.systemPackages, home.path covers the home-manager packages
      # that useUserPackages keeps out of it (git, firefox, starship, zsh).
      # Nothing creates /run/current-system here, so PATH names the two store
      # paths directly.
      path = lib.concatStringsSep ":" [
        "${config.system.path}/bin"
        "${config.system.path}/sbin"
        "${config.home-manager.users.administrator.home.path}/bin"
      ];
    in
    {
      imports = [ (modulesPath + "/image/file-options.nix") ];
      # buildLayeredImage's `name` is what ends up on disk and in the loaded image
      # reference, so it matches the flake output rather than anything else here.
      #
      # Deliberately not systemd. As PID 1 it insists on mounting /proc, /sys,
      # /dev and tmpfs itself and exits when it cannot, which needs
      # CAP_SYS_ADMIN and so forces --privileged on every run. Nothing here needs
      # a running system: etc is baked in below, so the filesystem is complete
      # without an activation pass. What this costs is systemd itself, and with
      # it every service, getty login, dbus and NetworkManager.
      system.build.image = pkgs.dockerTools.buildLayeredImage {
        name = "nixos-oci";
        tag = "latest";
        # Order matters: each layer wins over the ones before it, so etc has to come
        # after system.path, which also carries parts of /etc, and shell last.
        contents = [
          config.system.build.toplevel
          config.system.path
          config.system.build.etc
          shell
        ];
        config = {
          Cmd = [ "/bin/sh" ];
          Env = [ "PATH=${path}" ];
        };
      };
    }
  );
}

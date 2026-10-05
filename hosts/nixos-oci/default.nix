# nixos-oci - a development, test and run environment packaged as a container
# filesystem.
#
# Deliberately not a disk image. The OCI cloud-image path (system.build.OCIImage
# in nixpkgs) produces a qcow2 with a partition table that boots its own kernel,
# and it hardcodes an 8 GiB disk, which is what ran out of space. A container has
# neither: nothing boots inside it, so there is no disk to size at all.
#
# Swap is the host's business: zram and a swapfile both need an init system to
# set them up, and this image runs none.
{
  pkgs,
  lib,
  hostName,
  ...
}:

{
  imports = [
    ../common/core
    ../common/optional/security-hardening.nix
    ../common/optional/programs.nix
    ../common/optional/ssh.nix
    ../common/optional/sing-box.nix
    ../common/optional/wireguard.nix
    ../common/optional/wireshark.nix
    ../common/packages/nixpkgs-config.nix
    ../common/packages/network
    ../common/packages/system
    ../common/packages/dev
    ../common/packages/docs
    ../common/packages/security
    ../common/packages/ai
    # qemu for running a guest or a foreign binary, without the rest of the group:
    # libvirt, docker and waydroid all need a host this image cannot offer.
    ../common/packages/virtual/misc.nix
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

  # container-config.nix assumes a systemd-nspawn container that borrows the host's
  # nix-daemon, and boot.isContainer above is what pulls it in -- but nothing here
  # runs a daemon. Overriding here rather than in the image's Env is the point:
  # /etc/profile renders environment.variables, so anything set downstream gets
  # overwritten. local is the single-user counterpart, matching the setting below.
  environment.variables.NIX_REMOTE = lib.mkForce "local";

  # The build sandbox needs namespaces this image cannot create: it runs without
  # CAP_SYS_ADMIN so that it needs no --privileged (see the note on systemd in
  # image.modules.oci below). nixpkgs also disables sandbox-fallback, so without
  # this every build fails outright rather than degrading.
  nix.settings = {
    sandbox = false;
    # Silent when unset, and single-user is the right mode for a container.
    build-users-group = "";
  };

  networking.hostName = hostName;

  aiCodingAgents.channel = "unstable";

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
        # A single buildEnv rather than the four paths directly. symlinkJoin, which
        # consumes `contents`, merges with lndir -silent, and lndir does not
        # descend into a symlinked directory. system.build.toplevel carries its
        # /etc as a symlink to system.build.etc (top-level.nix), so the flattened
        # pass never reached the 125 entries behind it -- /etc/nix was absent and
        # nix refused every command with "experimental Nix feature 'nix-command' is
        # disabled". buildEnv recurses through real directories instead.
        #
        # `contents` is deprecated in favour of `copyToRoot`, but only buildImage
        # accepts that one, and a single-layer image this size would be rebuilt
        # from scratch on every configuration change.
        contents = [
          (pkgs.buildEnv {
            name = "nixos-oci-root";
            # Every path here carries the default meta.priority, so builder.pl's
            # $priority < $oldPriority test never fires and the first path listed
            # keeps each contested name. system.path republishes the etc directories
            # of packages it installs -- dbus is built with --sysconfdir=/etc, for
            # one -- so it collides with system.build.etc on files that resolve to
            # the same place by different routes. Letting those through leaves
            # /etc owned by system.build.etc, which is the point of it.
            ignoreCollisions = true;
            paths = [
              config.system.build.etc
              # NixOS writes the nss files out of users.users during activation,
              # which an image never runs, so without them getpwuid(0) fails: bash
              # answers with a literal "I have no name!" and whatever resolves a
              # home directory settles on / instead. dockerTools' examples.nix does
              # the same with nonRootShadowSetup. Only root, because the image runs
              # as uid 0 and administrator's uid is still null here.
              (pkgs.writeTextDir "etc/passwd" ''
                root:x:0:0:System administrator:/root:/bin/bash
              '')
              (pkgs.writeTextDir "etc/group" "root:x:0:")
              config.system.path
              shell
            ];
          })
        ];
        # Without this the store directory is populated but its database is not,
        # so nix inside the container decides nothing is installed.
        includeNixDB = true;
        # /etc/profile derives PATH, LOCALE_ARCHIVE and a dozen other variables
        # from environment.profiles, and here those are either profiles nothing
        # creates or paths under /run/current-system. An interactive bash
        # sources it and finds nothing, so no external command resolves. Setting
        # the variables ourselves would only win where we remember to repeat
        # ourselves; giving /run/current-system/sw the one directory they all
        # point at fixes the whole set at once, as nix's docker.nix does.
        # /lib is among system.path's pathsToLink, so the locale archive comes
        # with it.
        fakeRootCommands = ''
          mkdir -p run/current-system var
          ln -s /run var/run
          ln -s ${config.system.path} run/current-system/sw
          # buildLayeredImage's root has no /tmp either, and nix-shell fails
          # outright rather than degrading when it cannot create its own.
          mkdir tmp && chmod 1777 tmp
          # The home /etc/passwd above promises; without it $HOME resolves to a
          # path that cannot be written to.
          mkdir root
        '';
        config = {
          Cmd = [ "/bin/sh" ];
          Env = [
            "PATH=${path}"
            # nix refuses to start without one; the nixpkgs example that ships a
            # usable container nix sets this alongside NIX_PAGER.
            "USER=root"
          ];
        };
      };
    }
  );
}

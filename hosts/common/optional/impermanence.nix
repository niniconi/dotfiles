# impermanence.nix - State Persistence Whitelist via Impermanence
{ inputs, config, pkgs, userName, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/var/log"
      "/var/lib/AccountsService"
      "/var/lib/bluetooth"
      "/var/lib/colord"
      "/var/lib/docker"
      "/var/lib/gdm"
      "/var/lib/geoclue"
      "/var/lib/gnome-remote-desktop"
      "/var/lib/libvirt"
      "/var/lib/lxc"
      "/var/lib/machines"
      "/var/lib/misc"
      "/var/lib/nixos"
      "/var/lib/portables"
      "/var/lib/power-profiles-daemon"
      "/var/lib/qemu"
      "/var/lib/sbctl"
      "/var/lib/systemd/coredump"
      "/var/lib/udisks2"
      "/var/lib/upower"
      "/var/lib/waydroid"
      "/etc/NetworkManager/system-connections"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];

    users.${userName} = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Projects"
        "Public"
        "Templates"
        "Vieos"
        ".gnupg"
        ".ssh"
        ".cache"
        ".local"
      ];
      files = [
        ".zsh_history"
        ".bash_history"
      ];
    };
  };

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";
}

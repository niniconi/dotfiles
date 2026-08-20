# impermanence.nix - State Persistence Whitelist via Impermanence
{ inputs, config, pkgs, userName, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
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
        ".local/share/keyrings"
        ".local/share/nvim"
        ".local/state/nvim"
      ];
      files = [
        ".bash_history"
      ];
    };
  };

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";
}

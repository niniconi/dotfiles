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
        "Videos"
        ".gnupg"
        ".ssh"
        ".cache"
        ".local"
        ".rustup"
        # Firefox
        ".config/mozilla"
        # DMS Shell
        ".config/DankMaterialShell"
        # android
        ".android"
        # java
        ".gradle"
      ];
      files = [
        ".zsh_history"
        ".bash_history"
        # DMS Shell - GTK
        ".config/gtk-3.0/dank-colors.css"
        ".config/gtk-4.0/dank-colors.css"
        # DMS Shell - Qt
        ".config/qt5ct/colors/matugen.conf"
        ".config/qt6ct/colors/matugen.conf"
        # DMS Shell - Editors
        ".config/nvim/colors/dms.lua"
        ".config/nvim/lua/lualine/themes/dms.lua"
        # DMS Shell - Terminals
        ".config/foot/dank-colors.ini"
        ".config/alacritty/dank-theme.toml"
        ".config/kitty/dank-tabs.conf"
        ".config/kitty/dank-theme.conf"
      ];
    };
  };

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";
}

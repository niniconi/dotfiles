{
  pkgs,
  lib,
  hostName,
  users,
  ...
}:

{
  imports = [
    ../common/optional/impermanence.nix
    ../common/optional/swap.nix
    ./hardware.nix
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

  # *.md resolves to the canonical text/markdown, while Apostrophe only declares
  # the text/x-markdown alias, and its desktop id is not the package name.
  xdg.mime.defaultApplications."text/markdown" = "org.gnome.gitlab.somas.Apostrophe.desktop";

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

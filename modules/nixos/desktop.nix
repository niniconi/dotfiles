# The NixOS half of the desktop: everything that is not a fact about one
# machine. A host imports this and adds its hardware, boot and disk layout.
{ ... }:

{
  imports = [
    ../dotfiles.nix
    ../options.nix
    ../validation.nix
    ../sops.nix
    ../../hosts/common/core
    ../../hosts/common/optional/dms.nix
    ../../hosts/common/optional/input-method.nix
    ../../hosts/common/optional/niri.nix
    ../../hosts/common/optional/programs.nix
    ../../hosts/common/optional/security-hardening.nix
    ../../hosts/common/optional/sing-box.nix
    ../../hosts/common/optional/ssh.nix
    ../../hosts/common/optional/valent.nix
    ../../hosts/common/optional/wireshark.nix
    ../../hosts/common/optional/wireguard.nix
    ../../hosts/common/packages
  ];
}

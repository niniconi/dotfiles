# The private manifest: one entry per host. `mkModules` turns each of these
# into a nixosConfiguration.
{
  nixos = {
    diskDevice = "/dev/nvme0n1";

    # Directory holding `hosts/<host>/secrets.yaml` and `profiles.nix`, or
    # null to leave sops out. See the README for what it must contain.
    secrets = null;

    users = {
      administrator = {
        home = ./home.nix;
        passwordFile = "/persist/secrets/administrator-password";
      };
    };

    # Host policy the desktop does not cover: hardware, bootloader, disk
    # layout, activation checks.
    extraModules = [ ./host.nix ];
  };
}

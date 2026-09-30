# hosts/hosts.nix - Host configuration manifest
# users maps a username to its home configuration and password file
{
  "nixos" = {
    diskDevice = "/dev/nvme0n1";
    users = {
      "administrator" = {
        home = ../home/nixos/administrator/home.nix;
        passwordFile = "/persist/secrets/administrator-password";
      };
    };
  };
}

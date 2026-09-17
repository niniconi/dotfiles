# hosts/hosts.nix - Host configuration manifest
# Each host defines: diskDevice, users (username -> home path + password file)
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

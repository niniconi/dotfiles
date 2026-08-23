# secrets/profiles.nix - User profiles data (pure data, no NixOS module)
{
  "administrator" = {
    git = {
      name = "myrealname";
      email = "private-work@domain.com";
    };
    ssh = {
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIUSERKEY... user@desktop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIUSERKEY... user@laptop"
      ];
      hosts = {
        "github.com" = {
          user = "git";
          sopsSecret = "ssh/id_ed25519_github";
        };
        "myserver" = {
          hostname = "192.168.1.100";
          user = "admin";
          port = 2222;
          sopsSecret = "ssh/id_ed25519_server";
        };
        "work-server" = {
          hostname = "10.0.0.50";
          user = "deploy";
          sopsSecret = "ssh/id_ed25519_work";
          forwardX11 = true;
        };
      };
    };
    hosts = {
      "nixos" = {
        gitSigningKey = "0x1111222233334444";
      };
    };
  };
}

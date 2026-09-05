# secrets/profiles.nix - User profiles data (pure data, no NixOS module)
{
  "administrator" = {
    git = {
      name = "myrealname";
      email = "private-work@domain.com";
      signingKey = "0x1111222233334444";
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
    sing-box = {
      enable = true;
      settings = {
        route = {
          rules = [
            {
              protocol = "dns";
              action = "hijack-dns";
            }
          ];
        };
        inbounds = [
          {
            type = "tun";
            tag = "tun-in";
            interface_name = "tun0";
            auto_route = true;
            strict_route = true;
            stack = "system";
            sniff = true;
          }
        ];
        outbounds = [
          {
            type = "direct";
            tag = "direct";
          }
          {
            type = "block";
            tag = "block";
          }
        ];
      };
    };
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          listenPort = 51820;
          autostart = true;
          privateKey = "YOUR_PRIVATE_KEY_HERE";
          address = [ "10.0.0.2/32" ];
          dns = [ "192.168.1.1" ];
          peers = [
            {
              publicKey = "SERVER_PUBLIC_KEY_HERE";
              allowedIPs = [ "0.0.0.0/0" "::/0" ];
              endpoint = "server.example.com:51820";
              persistentKeepalive = 25;
            }
          ];
        };
      };
    };
  };
}

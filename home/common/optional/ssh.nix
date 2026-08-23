{ config, pkgs, lib, userName, profiles, ... }:

let
  profile = profiles.${userName} or {};
  ssh = profile.ssh or {};
  hosts = ssh.hosts or {};
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = lib.mapAttrs' (name: host: {
      name = name;
      value = {
        HostName = host.hostname or name;
        User = host.user or "root";
        Port = host.port or 22;
      } // lib.optionalAttrs (host.sopsSecret or null != null) {
        IdentityFile = "~/.ssh/${builtins.baseNameOf host.sopsSecret}";
      } // lib.optionalAttrs (host.forwardX11 or false) {
        ForwardX11 = "yes";
      };
    }) hosts;
  };
}

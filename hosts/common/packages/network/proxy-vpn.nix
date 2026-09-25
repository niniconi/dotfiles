# proxy/VPN - proxy and VPN tools

{ pkgs, ... }:

{
  # OpenVPN: NM plugin for GUI connections + CLI fallback
  networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];

  environment.systemPackages = with pkgs; [
    # proxy/VPN
    openvpn
    sing-box
  ];
}

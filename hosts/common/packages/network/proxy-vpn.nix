# proxy/VPN - proxy and VPN tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # proxy/VPN
    sing-box
  ];
}

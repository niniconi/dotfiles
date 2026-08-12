# network - network tools (network-utils)
# networkmanager is enabled via networking.networkmanager.enable (see configuration.nix)

{ config, pkgs, ... }:

{
  networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];

  environment.systemPackages = with pkgs; [
    # network diagnostics/monitoring
    net-tools
    lsof
    ethtool
    iperf3
    # port scanning
    nmap
    masscan
    arp-scan
    rustscan
    trippy
    nexttrace
    # connection tools
    netcat-openbsd
    socat
    wol
    proxychains
    # proxy/VPN
    sing-box
    # browsers
    firefox
    chromium
    tor-browser
    # DNS
    bind
    # attack framework
    python3Packages.impacket
  ];
}

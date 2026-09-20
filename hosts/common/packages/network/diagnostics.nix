# network diagnostics - network diagnostics/monitoring tools

{ pkgs, ... }:

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
    # DNS
    bind
  ];
}

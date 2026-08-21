# forensics - digital forensics (forensics-utils)

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # volatility3 was restored after URL fix (HTTP 200, 2.28.0, allowUnfree)
    volatility3
    termshark
    wireshark-cli
    wireshark
    tcpdump
    ecapture
    dive
  ];
}

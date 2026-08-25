# Wireshark configuration - allows non-root users to capture packets

{ pkgs, ... }:

{
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;  # Allow network capture for wireshark group
  };
}

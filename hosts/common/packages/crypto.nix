# crypto - cryptography/steganography (crypto-utils + stego-utils)

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # password cracking
    hashcat
    z3
    # steganography
    zsteg
    stegsolve
  ];
}

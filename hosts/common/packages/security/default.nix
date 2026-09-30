# security - pentest/redteam/CTF tools

{ ... }:

{
  imports = [
    ./recon.nix
    ./exploit.nix
    ./fuzzers.nix
    ./reversing.nix
    ./forensics.nix
    ./crypto.nix
    ./password.nix
    ./wireless.nix
    ./windows.nix
    ./container-security.nix
    ./blockchain.nix
    ./code-audit.nix
  ];
}

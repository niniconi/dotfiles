# Package modules grouped by use case (migrated from deploy-repo/archlinux)
# Duplicates across groups are intentional for independent group toggling.

{ pkgs, ... }:

{
  imports = [
    ./blockchain.nix
    ./cli.nix
    ./container.nix
    ./code.nix
    ./dev.nix
    ./gui.nix
    ./kubernetes.nix
    ./network.nix
    ./recon.nix
    ./exploit.nix
    ./fuzzers.nix
    ./reversing.nix
    ./traffic.nix
    ./forensics.nix
    ./crypto.nix
    ./virtual.nix
    ./windows.nix
    ./wireless.nix
    ./fonts-zh.nix
    ./ai.nix
    ./docs.nix
    ./dotfiles.nix
    ./nixos.nix
    ./password.nix
    ./cargo.nix
  ];

  environment.systemPackages = [
    (pkgs.python3.withPackages (ps: with ps; [
      # cli.nix
      openapi-pydantic
      pydantic
      pydantic-core
      textual
      textual-autocomplete
      openapi-spec-validator
      # crypto.nix
      pycryptodome
      cryptography
      z3-solver
      # dev.nix
      flask
      requests
      selenium
      # exploit.nix
      pwntools
      capstone
      ropper
      # forensics.nix
      pyshark
      # network.nix
      impacket
      scapy
      dpkt
      # reversing.nix
      frida-python
      keystone-engine
      unicorn
      pyqtgraph
      numba
      python-gnupg
      r2pipe
      lief
      pefile
      pyghidra
      # angr deps
      archinfo
      cachetools
      cffi
      claripy
      cle
      cxxheaderparser
      gitpython
      mulpyplexer
      networkx
      protobuf
      psutil
      pycparser
      pydemumble
      pyformlang
      pypcode
      pyvex
      rich
      sortedcontainers
      sympy
      typing-extensions
      unique-log-filter
      # angr-management deps
      ipython
      pyside6
      bidict
      qtawesome
      qtconsole
      qtpy
      rpyc
      thefuzz
      tomlkit
    ]))
  ];
}

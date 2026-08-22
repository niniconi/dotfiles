# Package modules grouped by use case (migrated from deploy-repo/archlinux)
# Duplicates across groups are intentional for independent group toggling.

{ config, pkgs, ... }:

{
  imports = [
    ./cli.nix
    ./dev.nix
    ./gui.nix
    ./network.nix
    ./recon.nix
    ./exploit.nix
    ./reversing.nix
    ./forensics.nix
    ./crypto.nix
    ./virtual.nix
    ./fonts-zh.nix
    ./ai.nix
    ./docs.nix
    ./dotfiles.nix
    ./nixos.nix
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
      # reversing.nix
      frida-python
      keystone-engine
      unicorn
      pyqtgraph
      numba
      python-gnupg
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

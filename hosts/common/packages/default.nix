# Package modules grouped by use case (migrated from deploy-repo/archlinux)
# Duplicates across groups are intentional for independent group toggling.

{ pkgs, ... }:

{
  imports = [
    ./security/default.nix
    ./network/default.nix
    ./dev/default.nix
    ./system/default.nix
    ./gui/default.nix
    ./virtual/default.nix
    ./ai/default.nix
    ./docs/default.nix
  ];

  environment.systemPackages = [
    (pkgs.python3.withPackages (
      ps: with ps; [
        # graphics
        matplotlib
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
      ]
    ))
  ];
}

# Package modules grouped by use case (migrated from deploy-repo/archlinux)
# Duplicates across groups are intentional for independent group toggling.

{
  lib,
  pkgs,
  minimalPackages,
  ...
}:

{
  # A module argument rather than an option on purpose: a module cannot read its
  # own option back out of `config` while `imports` is still being collected, and
  # mkIf in an imports list is rejected too. specialArgs sidesteps both, and the
  # repository already threads hostName and profiles the same way.
  #
  # Setting it drops the groups that dominate a disk or image footprint: the
  # mobile toolchain (Flutter plus the Android SDK), the AI tools, the container
  # and VM stacks, the desktop applications, and the bundled python environment.
  imports = [
    ./network/default.nix
    ./system/default.nix
    ./dev/default.nix
    ./docs/default.nix
    ./security/default.nix
  ]
  ++ lib.optionals (!minimalPackages) [
    ./gui/default.nix
    ./virtual/default.nix
    ./ai/default.nix
    ./mobile/default.nix
  ];

  # Every entry below is pulled in by a package in this tree, so the whitelist
  # lives next to them instead of being repeated in each host.
  nixpkgs.config = {
    allowUnfree = false;
    allowUnfreePredicate =
      pkg:
      builtins.elem (pkgs.lib.getName pkg) [
        "volatility3" # memory forensics
        "unrar" # rar extraction
        # androidenv (objection dependency): composed wrappers use the
        # android-sdk-* prefix, raw archives use the bare package name.
        "android-sdk-cmdline-tools"
        "android-sdk-platform-tools"
        "android-sdk-build-tools"
        "android-sdk-cmake"
        "android-sdk-platforms"
        "android-sdk-sources"
        "android-sdk-tools"
        "android-sdk-emulator"
        "android-sdk-ndk"
        "cmdline-tools"
        "platform-tools"
        "build-tools"
        "cmake"
        "platforms"
        "sources"
        "tools"
        "emulator"
        "ndk"
        "ndk-bundle"
        "extras"
        "patcher"
        "skiaparser"
        "system-images"
        "addons"
      ];
    android_sdk.accept_license = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
      "openclaw-2026.5.7"
    ];
  };

  environment.systemPackages = lib.optionals (!minimalPackages) [
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

# reversing - reverse engineering (reversing-utils + angr deps)

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # decompilers/disassemblers
    ghidra
    jadx
    apktool
    imhex
    radare2
    detect-it-easy
    # mobile/Android reversing
    scrcpy
    objection
    androguard
    python3Packages.frida-python
    frida-tools
    # malware sample analysis
    foremost
    binwalk
    sleuthkit
    binsider
    # unpackers
    arj
    cabextract
    mtdutils
    unrar
    lhasa
    squashfsTools
    sasquatch
    upx
    asar
    # MITM/traffic
    mitmproxy
    # binary analysis engines
    python3Packages.capstone
    python3Packages.keystone-engine
    python3Packages.unicorn
    z3
    python3Packages.pyqtgraph
    python3Packages.numba
    python3Packages.python-gnupg
    # angr deps (angr itself removed: nixpkgs build fails)
    python3Packages.archinfo
    python3Packages.cachetools
    python3Packages.cffi
    python3Packages.claripy
    python3Packages.cle
    python3Packages.cxxheaderparser
    python3Packages.gitpython
    python3Packages.mulpyplexer
    python3Packages.networkx
    python3Packages.protobuf
    python3Packages.psutil
    python3Packages.pycparser
    python3Packages.pydemumble
    python3Packages.pyformlang
    python3Packages.pypcode
    python3Packages.pyvex
    python3Packages.rich
    python3Packages.sortedcontainers
    python3Packages.sympy
    python3Packages.typing-extensions
    python3Packages.unique-log-filter
    # angr-management deps (removed: libbs build fails)
    python3Packages.ipython
    python3Packages.pyside6
    python3Packages.bidict
    python3Packages.qtawesome
    python3Packages.qtconsole
    python3Packages.qtpy
    python3Packages.rpyc
    python3Packages.thefuzz
    python3Packages.tomlkit
  ];
}

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
  ];
}

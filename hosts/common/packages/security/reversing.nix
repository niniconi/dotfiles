# reversing - reverse engineering (reversing-utils + angr deps)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # decompilers/disassemblers
    (ghidra.withExtensions (p: with p; [
      findcrypt                    # Crypto constant detection
      ghidra-delinker-extension    # Delink executables to object files
      ghidra-firmware-utils        # Firmware analysis utilities
      ghidra-golanganalyzerextension  # Go binary analysis
      ghidraninja-ghidra-scripts   # Collection of Ghidra scripts
      gnudisassembler              # GNU disassembler integration
      kaiju                        # CERT malware analysis tools
      lightkeeper                  # Code coverage visualization (Lighthouse port)
      machinelearning              # ML-based analysis
      ret-sync                     # Sync with external debuggers
      sleighdevtools               # Sleigh language development tools
      wasm                         # WebAssembly support
    ]))
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

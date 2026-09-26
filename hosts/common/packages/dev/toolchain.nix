# toolchain - base build toolchain

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # base build tools
    gcc
    gnumake
    cmake
    go
    # CI/automation
    act
    github-cli
    # eBPF/kernel debug
    bpf-linker
    bpftrace
    dtc
    ubootTools
    # terminal image (chafa provides libchafa for TUI frameworks)
    chafa
    glew
    iverilog
    ltrace
    strace
    trace-cmd
    wabt
    wasmtime
    zig
    kernelshark
    perf
  ];
}

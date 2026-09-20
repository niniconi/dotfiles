# toolchain - base build toolchain

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # base build tools
    gcc
    gnumake
    cmake
    # CI/automation
    act
    github-cli
    # eBPF/kernel debug
    bpf-linker
    bpftrace
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

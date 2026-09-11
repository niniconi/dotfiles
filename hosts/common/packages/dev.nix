# dev - development toolchain (development-utils + verified rust-utils)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # base build tools
    gcc
    gnumake
    # CI/automation
    act
    github-cli
    # mobile dev
    android-tools
    fvm
    sdkmanager
    scrcpy
    # eBPF/kernel debug
    bpf-linker
    bpftrace
    # terminal image (chafa provides libchafa for TUI frameworks)
    chafa
    cmake
    dbeaver-bin
    sqlite
    geckodriver
    glew
    gradle
    iverilog
    ltrace
    maven
    nodejs
    rustup
    strace
    trace-cmd
    wabt
    wasmtime
    zig
    # JDK multi-version
    jdk
    jdk8
    jdk11
    jdk17
    jdk21
    kernelshark
    mariadb
    perf
    # media
    ffmpeg-full
    sox
    v4l-utils
  ];
}

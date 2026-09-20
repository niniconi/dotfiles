# java - Java development tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # JDK multi-version
    jdk
    jdk8
    jdk11
    jdk17
    jdk21
    # build tools
    gradle
    maven
  ];
}

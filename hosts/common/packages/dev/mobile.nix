# mobile - mobile development tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # mobile dev
    android-tools
    fvm
    sdkmanager
    scrcpy
  ];
}

# browsers - web browsers

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # browsers
    firefox
    chromium
    tor-browser
  ];
}

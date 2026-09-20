# media-prod - media production tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # media
    ffmpeg-full
    sox
    v4l-utils
  ];
}

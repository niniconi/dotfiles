# media-prod - media production tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # media
    ffmpeg-full
    sox
    v4l-utils
    # metadata and image/document processing
    exiftool
    imagemagick
    poppler-utils
    # network video download (mpv pairing: mpv <url>)
    yt-dlp
  ];
}

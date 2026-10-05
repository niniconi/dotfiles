# oversized - packages a trimmed test VM leaves behind
#
# None of these is wrong on a full system; they are only too big for an image
# whose job is to exercise the desktop.
{
  config,
  lib,
  pkgs,
  ...
}:

let
  # RetroArch decides a font path is a "fallback" request by substring match and
  # then hands the choice to fontconfig, which resolves sans-serif to DejaVu
  # Sans and renders CJK as tofu. The bundled chinese-fallback-font.ttf contains
  # "fallback" in its path and is therefore ignored, so point at a CJK face
  # outside retroarch-assets. Verified for the rgui, xmb and ozone drivers;
  # materialui is untested.
  cjkFont = "${pkgs.wqy_zenhei}/share/fonts/wqy-zenhei.ttc";
  retroarch = pkgs.retroarch-bare.wrapper {
    settings = {
      ozone_font = cjkFont;
      xmb_font = cjkFont;
      video_font_path = cjkFont;
    };
  };
in
{
  # Default on: a host that wants them trimmed says so, rather than the option
  # being something every host has to remember to turn on.
  options.oversizedPackages.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether to install the packages too large for a test VM.";
  };

  config.environment.systemPackages = lib.mkIf config.oversizedPackages.enable (
    with pkgs;
    [
      blender
      gimp
      krita
      inkscape
      obs-studio
      audacity
      opentabletdriver
      kdePackages.kdenlive
      libreoffice
      thunderbird
      retroarch
      libretro-core-info
      ruffle
      virt-manager
    ]
  );
}

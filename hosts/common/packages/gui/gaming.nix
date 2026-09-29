# gaming - games and emulators

{ pkgs, ... }:

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
  environment.systemPackages = with pkgs; [
    # games/emulators
    ruffle
    retroarch
    libretro-core-info
  ];
}

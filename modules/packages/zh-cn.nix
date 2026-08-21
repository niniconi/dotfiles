# zh-cn - Chinese localization (fonts + fcitx5)

{ config, pkgs, lib, ... }:

{
  fonts.packages = with pkgs; [
    source-han-sans
    source-han-serif
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    wqy_microhei
    wqy_zenhei
    arphic-ukai
    arphic-uming
    pkgs.nerd-fonts.fira-code
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5
        qt6Packages.fcitx5-configtool
        fcitx5-gtk
        qt6Packages.fcitx5-qt
        qt6Packages.fcitx5-chinese-addons
        fcitx5-pinyin-zhwiki
        fcitx5-mozc
      ];
      waylandFrontend = true;
    };
  };
}

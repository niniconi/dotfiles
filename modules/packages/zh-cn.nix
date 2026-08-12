# zh-cn - Chinese localization (fonts + fcitx5)

{ config, pkgs, lib, ... }:

{
  # Chinese fonts
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

  # input method fcitx5
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5
      pkgs.qt6Packages.fcitx5-configtool
      fcitx5-gtk
      pkgs.libsForQt5.fcitx5-qt
      pkgs.qt6Packages.fcitx5-chinese-addons
      fcitx5-mozc
      fcitx5-pinyin-zhwiki
    ];
  };
}

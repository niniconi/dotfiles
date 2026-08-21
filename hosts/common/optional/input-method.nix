# zh-cn - Chinese input method (fcitx5)

{ config, pkgs, lib, ... }:

{
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

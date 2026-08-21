# fonts-zh - Chinese fonts

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
}

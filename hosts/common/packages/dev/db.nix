# db - database tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sqlite
    dbeaver-bin
    mariadb
  ];
}

# docker - Docker container tools

{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.docker.enable = true;

  users.users = lib.mapAttrs (_: _: { extraGroups = [ "docker" ]; }) config.dotfiles.users;

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    docker-buildx
    dive
  ];
}

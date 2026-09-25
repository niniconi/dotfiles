# docker - Docker container tools

{ pkgs, ... }:

{
  virtualisation.docker.enable = true;

  users.users.administrator.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    docker-buildx
    dive
  ];
}

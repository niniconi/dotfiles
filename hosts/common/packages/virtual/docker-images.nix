# docker-images - a prebuilt toolbox image loaded into the Docker daemon at boot
#
# The Nix build sandbox has neither a network nor a Docker daemon, so an image
# cannot be assembled with `docker build` or provisioned with `pacman` while it
# is built. A stock Arch base is fetched as a fixed-output derivation and a
# provisioning script is baked in; run provision once inside a fresh container.
{
  config,
  lib,
  pkgs,
  ...
}:

let
  image = pkgs.dockerTools.buildImage {
    name = "archlinux-toolbox";
    tag = "latest";
    fromImage = pkgs.dockerTools.pullImage {
      imageName = "archlinux";
      imageDigest = "sha256:3c64b538588416593f69a1aebd2f2ec0f2541b29159f32556fa7def2167147a0";
      finalImageName = "archlinux";
      finalImageTag = "latest";
      os = "linux";
      arch = "amd64";
      hash = "sha256-0yOCWNYIKX5S3D9AX76lnZmC2db2cmTTClLgv4aZrok=";
    };
    copyToRoot = pkgs.runCommand "archlinux-toolbox" { } ''
      install -Dm755 ${./provision.sh} $out/usr/local/bin/provision
    '';
  };
in
{
  config = lib.mkIf config.oversizedPackages.enable {
    systemd.services.docker-load-image = {
      description = "Load the prebuilt toolbox image into Docker";
      wantedBy = [ "multi-user.target" ];
      after = [ "docker.service" ];
      requires = [ "docker.service" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        ${pkgs.docker}/bin/docker load --input ${image}
      '';
    };
  };
}
